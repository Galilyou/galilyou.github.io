---
layout: post
comments: true
permalink: "/blog/new-features-net-4"
title: New, But Not So Obvious, Features in .NET 4.0
date: '2010-03-14T14:42:00.000+02:00'
author: Galilyou
tags:
modified_time: '2010-03-14T21:16:39.598+02:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-3861216987829268500
blogger_orig_url: http://www.galilyou.com/2010/03/new-but-not-so-obvious-features-in-net.html
---

.NET 4.0 came out lately with a lot of new, cool, and somewhat game-changing features. These features include language features like the famous dynamic keyword in C# and this whole dynamic dispatching thing that made possible by the DLR (Dynamic Language Runtime).There are also some additions on the library level, the parallel extensions is an obvious example of that.

In this post I will mention some of the new additions that are not so well propagated.

**First The additions to the string class:**
The BCL guys are still working on the core. Apparently they are trying to lessen the number of extension methods that you need to write as a complement to some of the very core, and widely used in any application, classes -Pretty much everyone has a StringExtensions, and DateTimeExtensions dlls.

**string.IsNullOrWhiteSpace()**
The old string.IsNullOrEmpty() was used to check if the string variable is null or if it's equal to the empty string ("", or string.empty)In many cases a string that contains only white spaces is considered to be an empty string. People used to do the following check over and over again:

```csharp
if(string.IsNullOrEmpty(s) && s.Trim() != string.Empty)
{
 // do my job;
}
```
Now string.IsNullOrWhiteSpace() is designed to save you that extra Trim call.

**string.Join()**
Prior to .NET 4.0 string.Join was designed to accept two parameters a separator and an array of string, and it was expected to output one single string that contains the strings in the array separated by the separator. The problem with this is, if you have two separate strings and you want to join them together you would have to create an array and insert those two strings inside the array, then call string.Join passing in your separator of choice and the array. A call should look like this:

```csharp
string first = "first";
string second = "second";
string[] sequence = { first, second };
string joined = string.Join(" - ", sequence);
```

New overloads had been added to the string.Join method, one of them accepts a params of objects and it automatically calls ToString, so that you don't have to do that extra step of creating an array that holds your string values. Now the call to the method is simplified:

```csharp
string joined = string.Join(" - ", first, second);
```

**Modern collections support with string methods**
If you examine the old overloads of string methods that accept a collection, you shall find that the only collection these methods accept, is array. With .NET 4.0 things are different, now these methods support IList<T>, ICollection<T>, and IEnumerable<T> (yeah, I know, this should have been possible since .NET 2.0). With this support statments like this are possible:

```csharp
string joined  = string.Join(" - ", stringList.Where(s => s.Length > 3).Select(s=> s));
```

#### Second, Lazy<T>

Lazy Loading, is a technique that implies, creating and initializing expensive objects on demand. Most nowadays ORMs follow this technique when fetching data from the database. The Lazy<T> is a new type introduced in .NET 4.0 that enables you to lazily create your instances and validate whether an instance has been created or not without accidently creating it.For example if I have an object named ExpensiveObject like so:

```csharp
class ExpensiveObject
 {
     public ExpensiveObject() { }
     public ExpensiveObject(string connection)
     {
         Console.WriteLine("Constructing expensive object");
         Connection = connection;
     }

     public string Connection { get; set; }
 }
```
Here's how I would Lazily create an instance of this object:

```csharp
Lazy<ExpensiveObject> a = new Lazy<ExpensiveObject>();
```

To check if the object has been already created or not, you can use IsValueCreated boolean propery on the Lazy<T> object:

```csharp
Console.WriteLine(a.IsValueCreated);
```
This should print false. If I tried to access the underlying expensive object (through the Value propery on Lazy<T>) and then check to see IsValueCreated, the result should be true:

```csharp
string  dummy = a.Value.Connection;
Console.WriteLine(a.IsValueCreated);
```

This statement should print True on the console window.

Note: In the above example we created an instance of ExpensiveObject using the default constructor. You can create it using a custom consructor by passing in a Func<expensiveobject> (i.e. any method that returns an expensive object)

```csharp
Lazy<expensiveobject> custom = new Lazy<expensiveobject>(() => new ExpensiveObject("My Connection"));
```

Hope this helps!