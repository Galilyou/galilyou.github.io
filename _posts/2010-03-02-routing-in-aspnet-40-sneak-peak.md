---
layout: post
comments: true
title: 'Routing in ASP.NET 4.0 : A Sneak Peak'
date: '2010-03-02T13:44:00.000+02:00'
author: Galilyou
tags: 
modified_time: '2010-03-02T13:44:30.836+02:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-1238800886658845864
blogger_orig_url: http://www.galilyou.com/2010/03/routing-in-aspnet-40-sneak-peak.html
---

<div class="separator" style="clear: both; text-align: center;"><a href="http://www.ciscorouting.com/routing_engine.jpg" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="217" src="http://www.ciscorouting.com/routing_engine.jpg" width="320" alt="Routing" /></a></div>
One of the cool features of ASP.NET MVC is the ability to provide clean, extension less, and SEO/user friendly urls. This is accomplished by using the new routing system in ASP.NET.
  
Before ASP.NET 4.0, people used to get these clean urls using a technique called <a href="http://weblogs.asp.net/scottgu/archive/2007/02/26/tip-trick-url-rewriting-with-asp-net.aspx">UrlRewriting or UrlRewiring.</a> The technique did get the job done, but unfortunately was somewhat complicated and involved the use of third party components.

Now with ASP.NET 4.0, and with the addition of the new Routing System, we can get clean urls, like those we get with MVC, in Web Forms. 

To do this we need to first define our routes, seconde register them in the current RouteTable when the application starts.

For example let's assume that we have a page that should display the details of a certain product given its Id.
The url for this action should look something like "MySite.Com/Products/1". Routes have to be registered in your Application_Start in Global.asax. The code should look something like the following:

```csharp
void Application_Start(object sender, EventArgs e)
{
     RegisterRoutes(RouteTable.Routes);

}

void RegisterRoutes(RouteCollection routes)
{
    routes.MapPageRoute(
        "ProductDetails", 
        "Products/{id}", 
        "~/ProductDetails.aspx");
}
```

I'm leveraging the new <a href="http://msdn.microsoft.com/en-us/library/system.web.routing.routecollection.mappageroute(VS.100).aspx">MapPageRoute</a> method on the <a href="http://msdn.microsoft.com/en-us/library/system.web.routing.routecollection.aspx">RouteCollection </a>class inside System.Web.Routing.
The first argument of the method is the name of the route, in our case "ProductDetails".
The second parameter is the Url pattern for this route which in this case is the string "Products" followed by
the Id of the product.
The {Id} parameter is the name of the actual parameter added to the RouteData collection. This parameter can then be accessed by the page RouteData property like so:

```csharp
int id = Convert.ToInt32(RouteData.Values["Id"]);
```

RouteData is a shortcut property of RequestContext.RouteData. The above statment is equivalent to this one:

```csharp
int id = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values["Id"]);
```


Note:
This is a very trivial example. The routing system is pretty powerfull. It can enable you to do a lot of neat stuff with it for example, you can generate urls out of the routing values, you can also add regular expression constraints on your route parameters to differentiate what route matches which request.