# debug_generator.rb
# Based on ACTUAL in-container jekyll-feed v0.17.0 generator.rb
# Modified to include the debugging as per subtask instructions,
# by adding a speculative post processing loop into normalize_posts_meta.
# frozen_string_literal: true

module JekyllFeed
  class Generator < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      @site = site
      if disabled_in_development?
        Jekyll.logger.info "Jekyll Feed:", "Skipping feed generation in development"
        return
      end
      collections.each do |name, meta| # collections will call the modified normalize_posts_meta
        Jekyll.logger.info "Jekyll Feed:", "Generating feed for #{name}"
        (meta["categories"] + [nil]).each do |category|
          path = feed_path(:collection => name, :category => category)
          next if file_exists?(path)
          @site.pages << make_page(path, :collection => name, :category => category)
        end
      end
      generate_feed_by_tag if config["tags"] && !@site.tags.empty?
    end

    private

    MINIFY_REGEX = %r!(?<=>|})\s+!.freeze

    def config
      @config ||= @site.config["feed"] || {}
    end

    def feed_path(collection: "posts", category: nil)
      prefix = collection == "posts" ? "/feed" : "/feed/#{collection}"
      return "#{prefix}/#{category}.xml" if category
      # Ensure collections() is called to populate @collections if not already done.
      # This makes feed_path safer if called before collections() in generate().
      active_collections = collections unless @collections
      (@collections || {}).dig(collection, "path") || "#{prefix}.xml"
    end

    def collections
      return @collections if defined?(@collections)
      @collections = case config["collections"]
                     when Array
                       config["collections"].map { |c| [c, {}] }.to_h
                     when Hash
                       config["collections"]
                     else
                       {}
                     end
      @collections = normalize_posts_meta(@collections) # Call the MODIFIED normalize_posts_meta
      @collections.each_value do |meta|
        meta["categories"] = (meta["categories"] || []).to_set
      end
      @collections
    end

    # MODIFIED normalize_posts_meta
    def normalize_posts_meta(current_collections_meta_hash)
      current_collections_meta_hash["posts"] ||= {}
      current_collections_meta_hash["posts"]["path"] ||= config["path"]
      current_collections_meta_hash["posts"]["categories"] ||= config["categories"]
      if current_collections_meta_hash["posts"]["path"]
        config["path"] ||= current_collections_meta_hash["posts"]["path"]
      end

      Jekyll.logger.info "JekyllFeed-Debug:", "Starting speculative post processing in normalize_posts_meta"
      @site.posts.docs.each_with_index do |post, index|
        puts "Processing post: #{post.path}"
        puts "Image data: #{post.data['image'].inspect}" if post.data['image']

        if post.data["image"].nil? && post.content.include?("<img")
          if post.content =~ /<img.*?src="(.*?)"/i
            if Regexp.last_match.nil?
              puts "JekyllFeed-Debug: Post #{post.path}: Img regex matched, but Regexp.last_match is nil. Accessing group 1 would error."
              begin
                dummy_meta = {}
                dummy_meta["image"] = Regexp.last_match(1) # This should raise IndexError
              rescue IndexError => e
                puts "JekyllFeed-Debug: Post #{post.path}: Successfully reproduced IndexError on assignment: #{e.message}"
                raise e unless ENV["JEKYLL_FEED_DEBUG_IGNORE_ERROR"] 
              end
            else
              # image_url_from_content = Regexp.last_match(1)
              # puts "JekyllFeed-Debug: Post #{post.path}: Found image in content: #{image_url_from_content}"
            end
          else
            # This case means the regex `/<img.*?src="(.*?)"/i` did not match at all.
            # Therefore, `Regexp.last_match` would be nil.
            # If the original code was `meta["image"] = Regexp.last_match(1)` *without* being guarded by `&&`
            # after the regex match, this would also cause an error.
            # The original line `post.content[/<img.*?src="(.*?)"/] && meta["image"] = Regexp.last_match(1)`
            # should prevent this path if written correctly.
            # Let's test this condition for safety.
            if Regexp.last_match.nil? # This will be true if the regex above didn't match
                puts "JekyllFeed-Debug: Post #{post.path}: Img regex did NOT match. Regexp.last_match is nil."
                # If line 141 was just `meta["image"] = Regexp.last_match(1)` it would error here too.
                begin
                    dummy_meta = {}
                    dummy_meta["image"] = Regexp.last_match(1) # This should raise IndexError
                rescue IndexError => e
                    puts "JekyllFeed-Debug: Post #{post.path}: Successfully reproduced IndexError (on no match path): #{e.message}"
                    raise e unless ENV["JEKYLL_FEED_DEBUG_IGNORE_ERROR"]
                end
            end
          end
        end
      end
      Jekyll.logger.info "JekyllFeed-Debug:", "Finished speculative post processing in normalize_posts_meta"
      current_collections_meta_hash
    end

    def generate_feed_by_tag
      tags_config = config["tags"]
      tags_config = {} unless tags_config.is_a?(Hash)
      except    = tags_config["except"] || []
      only      = tags_config["only"] || @site.tags.keys
      tags_pool = only - except
      tags_path = tags_config["path"] || "/feed/by_tag/"
      generate_tag_feed(tags_pool, tags_path)
    end

    def generate_tag_feed(tags_pool, tags_path)
      tags_pool.each do |tag|
        next if %r![^a-zA-Z0-9_]!.match?(tag)
        Jekyll.logger.info "Jekyll Feed:", "Generating feed for posts tagged #{tag}"
        path = "#{tags_path}#{tag}.xml"
        next if file_exists?(path)
        @site.pages << make_page(path, :tags => tag)
      end
    end

    def feed_source_path
      @feed_source_path ||= File.expand_path "feed.xml", __dir__
    end

    def feed_template
      @feed_template ||= File.read(feed_source_path).gsub(MINIFY_REGEX, "")
    end

    def file_exists?(file_path)
      File.exist? @site.in_source_dir(file_path)
    end

    def make_page(file_path, collection: "posts", category: nil, tags: nil)
      PageWithoutAFile.new(@site, __dir__, "", file_path).tap do |file|
        file.content = feed_template
        file.data.merge!(
          "layout"     => nil,
          "sitemap"    => false,
          "xsl"        => file_exists?("feed.xslt.xml"),
          "collection" => collection,
          "category"   => category,
          "tags"       => tags
        )
        file.output
      end
    end

    def disabled_in_development?
      config && config["disable_in_development"] && Jekyll.env == "development"
    end
  end 
end 

module JekyllFeed
  class PageWithoutAFile < Jekyll::Page
    def read_yaml(*)
      @data ||= {}
    end
  end
end
