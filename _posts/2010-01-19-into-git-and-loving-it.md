---
layout: post
comments: true
permalink: "/blog/git-101"
title: Into Git and Loving It
date: '2010-01-19T12:15:00.000+02:00'
author: Galilyou
tags:
- Git
- SourceControl
modified_time: '2010-02-01T13:30:39.929+02:00'
---

As it is gaining popularity day by day,and as everyone I know likes it, I thought .. well, let's give it a try.
Git is a powerful source control system. It's free, and open source. It's pretty simple to use, it's intended to handle both small and large projects, and it's so freakingly FAST.

<div class="separator" style="clear: both; text-align: center;"><a href="http://2.bp.blogspot.com/_CvP3b8RZYyc/S1WFeceVIxI/AAAAAAAAAEk/1V3HDGbOHBg/s1600-h/chp_rocket.jpg" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://2.bp.blogspot.com/_CvP3b8RZYyc/S1WFeceVIxI/AAAAAAAAAEk/1V3HDGbOHBg/s320/chp_rocket.jpg" /></a></div>

Unlike SVN and TFS, Git is not centeralized. This means that every Git clone is a fully fledged repository with all versions and history information available.

Git is written in C (well, mostly) and is available for many platforms. If you are a linux guy you can download Git from <a href="http://git-scm.com/">here</a> and if you are a Windows fellow then download <a href="http://code.google.com/p/msysgit/">msygit</a>.

This post is aimed to be a tutorial introduction to Git. Together we will walk through the process of creating the repository, adding initial files to the repository, committing those files, changing them, creating branches, viewing differences, resolving conflicts, merging and finally pushing to the centeralized repository.

Now to get started let's assume that you want to create a simple project which is basically an html file, a bunch of javascript files and a css file. Pick whatever directory you wish to create your initial files. After you're done right click the directory containing your files and select "Git Bash Here" (assuming that you already installed msygit). A command window will show up, to initialize your repository enter:

 ```git init-db```

This will create the repository for you (and will also create a default "master" branch). Now enter
 ```git add -a``` to add all the files in this directory to the repository. You can select specific files by specifying the required file name like so:


```git add filename.css```

The selected files are now tracked by Git to your repsoitory, to commit those files to the repository (the LOCAL repository, remember?):

 ```git commit -a```

This will open vim for you to enter a commit message. Enter your message, and quite vi, then Git will commit your changes to the DB.

**Note:**
*If you're not familiar with vim or vi, to quite the editor saving the changes type ":wq" -that's colon wq- or ":q" to quit without saving. Or you can specify -m to the git commit command followed by the message you want in double quotes, like so:*

```git commit -a -m "my initial commit"```

Now try editing some files and then, to view the changes, type:
 
```git diff```

This will highlight the changes between your uncommitted version and the last committed version. If you want to see the history of your changes at any time, user: 

```git whatchanged```

or use: ```git whatchanged -p``` to see the complete differences at each change.

The very cool thing about Git is how easily it enables you to create new branches. For example, if you want to create an expreimental function inside a class file you're working on or inside a javascript file but you want it away from the master branch, you can easily create a new branch, checkout this branch, edit your file, and all the changes will be completely isolated from the master branch. To create a new branch:

```git branch testBranch```
`git branch`

The first command will create testBranch for you and the second command will list all the available branches on your repository (by far there should be only testBranch and the master branch "master").

**Note:** *The selected branch has an * displayed before it.*

Now enter :

 ```git  checkout testBranch```

to switch to the newly created branch. Try editing somefiles, and show the diffs.

 ```git diff```
You should now see the changes you made, commit those changes. And switch to the master branch:

 ```
	git commit -a
	git checkout master
 ```

If you look at the files you just edited when you were on testBranch -after switching to the master branch- you would notice that the changes you made while you were on testBranch are gone. However, if you switch to the testBranch again you will see your changes there. If you're happy with the changes you made on testBranch, you can merge those changes to the master branch by using the following command:
 
 ```git merge testBranch```

If there is no confilcts, you're allset. If there are conflicts you will have to resolve them manually and then commit the file. Git will show you which files have conflicts.
Now, if you are done with the test branch and want to delte it, use:

 ```git branch -d testBranch
 ```

If you used to be a TFS and VSS guy like myself, take a deep sigh of relief and enjoy Git.
I will try to blog more on Git on the next posts, stay tuned!