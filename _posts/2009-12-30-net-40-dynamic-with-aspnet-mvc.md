---
layout: post
comments: true
permalink: "/blog/dynamic-asp-mvc"
title: ".NET 4.0 Dynamic with ASP.NET MVC"
date: '2009-12-30T15:38:00.000+02:00'
author: Galilyou
tags:
- asp.net mvc
- ".net"
- ".net 4.0"
- C#4.0
modified_time: '2009-12-31T09:16:29.733+02:00'
thumbnail: http://3.bp.blogspot.com/_CvP3b8RZYyc/SztaqgbrY2I/AAAAAAAAACk/HKbaG2G_RZ0/s72-c/view.png
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-7674113031753818092
blogger_orig_url: http://www.galilyou.com/2009/12/net-40-dynamic-with-aspnet-mvc.html
---

.NET 4.0 ships with a lot of cool, new stuff. For C# the major new feature is the support of dynamic programming. The idea with dynamic support in C#, in short, is that you can statically type a variable as dynamic (yeah, this sounds funny, statically typed as dynamic, I know) in which case the compiler will not check any methods or property binding on this object, rather it will defer all of these resolutions to runtime.
It's not just that, but with dynamic support you can also declare your own objects to act as dynamic objects by implementing IDynamicMetaObjectProvider or -- as a shortcut -- by extending DynamicObject. Both types exist in the namespace System.Dynamic.
There's also a very famous type called ExpandoObject.
ExpandoObject is a dynamic object that you can simply create properties on it at runtime.
Now the trick that I want to use, is to declare my views to extend the generic System.Web.Mvc.ViewPage<dynamic>. This will allow me to pass to my view any dynamic object and access its properties through the Model property of the view.
Here's a code example:
 ```csharp
 using System.Dynamic;
   cusing System.Web.Mvc;

    public class ArticlesController : Controller
    {
        public ViewResult Index()
        {

            dynamic x = new ExpandoObject();
            x.Title = "Programming for Cowards";
            x.Url = "http://galilyou.blogspot.com";
            //I even can nest
            x.Author = new ExpandoObject();
            x.Author.Name = "Galilyou";
            return View(x);
        }
    }
 ```
In the above code I declare an ExpandoObject and start to set some properties on it like Title, Url, etc.
I do this by simply using the syntax var.Property = value; which will <i>automagically </i>create a property on the dynamically created object which type will be the type of value.
If you look closely you would notice that  the Author property is an ExpandoObject itself. This nesting is allowed to as many levels as you want.
Here's how my view looks like:
 ```html
< %@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
</dynamic> ```
<div>
Note, the view is declared to extend System.Web.Mvc.ViewPage<dynamic>. </dynamic>
</div><div>Now you can use the values of the model like so:
 ```csharp
Model.Url
Model.Title
Model.Author.Name
 ```
here's how the entire view will look like:
<div class="separator" style="clear: both; text-align: center;"><a href="http://3.bp.blogspot.com/_CvP3b8RZYyc/SztaqgbrY2I/AAAAAAAAACk/HKbaG2G_RZ0/s1600-h/view.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://3.bp.blogspot.com/_CvP3b8RZYyc/SztaqgbrY2I/AAAAAAAAACk/HKbaG2G_RZ0/s640/view.png" /></a>
</div>And here's the page after running the application:
<div class="separator" style="clear: both; text-align: center;"><a href="http://1.bp.blogspot.com/_CvP3b8RZYyc/Szta0sl1MII/AAAAAAAAACs/ewxzqACj-CY/s1600-h/Untitled.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://1.bp.blogspot.com/_CvP3b8RZYyc/Szta0sl1MII/AAAAAAAAACs/ewxzqACj-CY/s640/Untitled.png" /></a>
</div>

<b>Disclaimer: </b>
<i>        You shouldn't do this in a large scale application. View model objects are still the best tool for the       job when the application grows. However, if you want to quirk something pretty quickly -- a small thing-- you might get away with that.</i>
</div><div>Hope this helps.
</div>