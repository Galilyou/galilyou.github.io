---
layout: post
comments: true
permalink: "/blog/memory-leak-net"
title: Opps! A Leak! In .NET!!
date: '2009-11-09T18:11:00.000+02:00'
author: Galilyou
tags:
- ".net"
- GarbageCollection
- Events
- MemoryManagement
modified_time: '2009-11-09T18:20:23.279+02:00'
---

Are you a smart, happy, hard-working C guy?
<div class="separator" style="clear: both; text-align: center;"><a href="http://4.bp.blogspot.com/_CvP3b8RZYyc/Svg9KNgdRfI/AAAAAAAAABo/aCQks9Iqdo4/s1600-h/Happy+C+Guy.jpg" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/_CvP3b8RZYyc/Svg9KNgdRfI/AAAAAAAAABo/aCQks9Iqdo4/s320/Happy+C+Guy.jpg" /></a>
</div>
If yes then, well .. &nbsp;you probably want to skip this post.
Do you use .NET? Are you aware of the magician called GarbageCollector? Do you like it? Because I do!

<b>Past --</b> Rewinding a little ... &lt;&lt;&lt;
In the times before dawn, every-day programmers needed to do a lot of work to manage their application's memroy. My hero C guy -I used to be&nbsp;a hero too by the way- was forced to keep track of every <i><b>malloc</b></i><b></b> to&nbsp;<i><b>free</b></i><b></b> it when it's no longer needed.

<b>Now --</b> Fastforwarding ... &gt;&gt;&gt;
Everyone (Well, almost everyone) uses a lanaguage that supports automatic memory management tools. For me as a .NET guy, I use C# and I'm&nbsp;very happy with what the GarbageCollector does for me (I think most .NET guys are). However, unlike everyone (again almost) else thinks,&nbsp;it's trivially easy to introduce memory leaks in .NET.

First let's ask Wikipedia, <a href="http://en.wikipedia.org/wiki/Memory_leak">What is Memory Leak</a>? &nbsp;Let me quote the answer here.

>A memory leak or leakage in computer science is a particular type of memory consumption by a computer program&nbsp;where the program is unable to release memory it has acquired.

I used to think that as long as I don't use unmanaged resources (explicitly) I'm safe. The GC will free all the managed objects from&nbsp;memory once I'm done using them (or when there is no references to these objects). Guess what? I was mistaken!!

One more point from this Wikipedia article:
<i> Languages that provide automatic memory management, like Java, C#, VB.NET or LISP,&nbsp;are not immune to memory leaks. For example, a program could create a circular loop of object references&nbsp;which the memory manager is unable to recognize as unreachable.</i>

GC frees only objects that has become unreachable. If the object is still reachable, somehow (probably your mistake), then&nbsp;GC will not free it. Which introduces a leak ...

To be honest, with nowadays super computers, usually leaks are not a problem unless your app is really big, and runs continously for a really long period of time;&nbsp;this is when those tiny drops can fill the cup.

<div class="separator" style="clear: both; text-align: center;"><a href="http://3.bp.blogspot.com/_CvP3b8RZYyc/Svg_PTYXmGI/AAAAAAAAABw/nQj7bxFT30M/s1600-h/Leak.jpg" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://3.bp.blogspot.com/_CvP3b8RZYyc/Svg_PTYXmGI/AAAAAAAAABw/nQj7bxFT30M/s320/Leak.jpg" /></a>
</div>

#### What causes those leaks?

There are quite a few reasons why a .NET app migh leak memory. The main reasons are:
<span style="white-space: pre;"> </span>1- Static References
<span style="white-space: pre;"> </span>2- Event With Missing Unsubscribtion
<span style="white-space: pre;"> </span>3- Dispose method not invoked.
<span style="white-space: pre;"> </span>
In this post, I will talk about the most famouse one (the one that got me bitten): <b>Events</b>.
Yes, people always remember to subscribe to events, but few unsubscribe from their events.

What happens when an observer subscribes to a publisher's event is that the publisher maintains a reference to the observer in order&nbsp;to call the event handler on that observer.&nbsp;This means that unsubscribtion from events is required to delete this reference.&nbsp;And that is what got me bitten hard!

<b>So, how to detect memroy leaks?</b>
There are plenty of tools that can help you track your application progress and take snapshots and analyze the memory status&nbsp;of your application. Here's a list of some of those tools:
<ol><li><b><a href="http://www.jetbrains.com/profiler/index.html">JetBrains dotTrace</a></b></li><li><a href="http://memprofiler.com/"><b>&nbsp;.NET Memory Profiler</b></a></li><li><a href="http://www.red-gate.com/products/ants_performance_profiler/index.htm"><b>ANTS Profiler</b></a></li></ol>And many others ...

I will post about other types of memroy leaks in .Net in the coming posts. So stay tuned!