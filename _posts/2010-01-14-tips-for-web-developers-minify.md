---
layout: post
comments: true
permalink: "/blog/js-minification"
title: 'Tips For Web Developers: Minify Javascript Using Google''s Closure Compiler'
date: '2010-01-14T11:57:00.000+02:00'
author: Galilyou
tags:
- page-speed
- javascript
- performance
modified_time: '2010-01-17T13:35:20.754+02:00'
thumbnail: http://2.bp.blogspot.com/_CvP3b8RZYyc/S07p4PJV_lI/AAAAAAAAADU/GxTJfORSPTA/s72-c/dampledoc.png
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-9073920255305817540
blogger_orig_url: http://www.galilyou.com/2010/01/tips-for-web-developers-minify.html
---

A faster web site is a goal for every develoepr. We spend a lot of time optimizing server code and processes, parallelizing stuff, indexing
and trying to enhance database performance. The goal behind all of these complicated actions is the ultimate goal: A Faster Site.
These actions are necessary and handy to decrease your site response time, however, there are a lot of stuff that we, developers, usually ignore. Those are the optimizations required to happen on the client side. These client side optimizations are as important (probably more imprtant) as the server side optimizations.
There are a lot of techniques to optimize the client side performance. These techniques include:


<ul><li>Making Less HTTP Requests</li><li>Optimizing JavaScript</li><li>Optimizing CSS</li></ul>

And many more. For full details about all the possible techniques, check out <a href="http://code.google.com/speed/page-speed/docs/rules_intro.html">Google's page speed initiative</a>.
In this post I will focus on optimizing javascript by minifying js files. For this I leverage <a href="http://code.google.com/closure/compiler/">Closure Compiler</a>, which is a very awesome tool to optimize Javascript developed by Google.
Now suppose that I have an html document that looks like the following:

<div class="separator" style="clear: both; text-align: center;"><a href="http://2.bp.blogspot.com/_CvP3b8RZYyc/S07p4PJV_lI/AAAAAAAAADU/GxTJfORSPTA/s1600-h/dampledoc.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://2.bp.blogspot.com/_CvP3b8RZYyc/S07p4PJV_lI/AAAAAAAAADU/GxTJfORSPTA/s320/dampledoc.png" /></a>
</div>

This document shall do a very little job actually. Simply a user keys his name in the textbox and clicks salute me which we will display a simple alert saying hello to this user.

Below are two buttons -hide, and show. As the name of each button implies, the hide button will hide the area including the label, text box, and the Salute me button.

To do this I'm gonna make use of jQuery 1.3.2. Here's the code needed to achieve the required functionality:

```js
/*
 The follwoing code is not part of jqueyr framework
*/
$(document).ready(function() {
 $('#hiFiver').click(function() {
  var userName = $('#txtName').val();
  alert ("Hello " + userName);
 });

 $('#showButton').click(function() {
  $('#hidden').show();
 });

 $('#hideButton').click(function() {
  $('#hidden').hide();
 });
});
```
 For the sake of this demo I will append my code at the end of the actual jQuery code itself. Now my app is working as required, and my Javascript file  size is 122 KB.

 Now let's run Closure Compiler and try to minify this.
 Closure Compiler is a java application, which means that you will need jre (Java Runtime Engine) to run it. You can download it from here

 Now I got my files (sample.html, script.js, compiler.jar) in one directory. To run the compiler, launch your terminal, and enter the follwoing command:

```java -jar compiler.jar --js script.js --js_output_file scriptMini.js```

 Check your directory. You should find a new file with the name "scriptMini.js" created. The new script file is 55 KB in size, which is less the half size  of the original file. To make sure it's working, change the script src attribute in the sample document to point to the new file. You should see that  the app is still functioning  properly.

 If you examin the newly created file, you will find that it doesn't contain any comments or spaces, all the optional semi-colons are removed, variable names are  changed to shorter names (usually one character long).

 The closure complier is a fascinating tool, it's really handy and easy to use.
 From now on you should develop the habit of always minifing your Javascript files.