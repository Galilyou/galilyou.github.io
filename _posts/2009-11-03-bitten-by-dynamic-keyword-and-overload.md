---
layout: post
title: Bitten by the dynamic Keyword and Overload Resolution in C#
date: '2009-11-03T15:53:00.000+02:00'
author: Galilyou
tags:
- C#
- C#4.0
- DynamicTyping
modified_time: '2010-01-03T16:28:51.652+02:00'
thumbnail: http://4.bp.blogspot.com/_CvP3b8RZYyc/SvAycn_HdWI/AAAAAAAAABc/TnNEbhHHSpE/s72-c/scary.jpg
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-7615591602053176198
blogger_orig_url: http://www.galilyou.com/2009/11/bitten-by-dynamic-keyword-and-overload.html
---

I came a cross a very scary piece of code Today on the web, take a look at the following C# 4.0 code:

```csharp
namespace DynamicDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            dynamic d = new ExpandoObject();
            d.Shoot = "Booom!";
            DoSomeThing(d);
        }

        void DoSomeThing(dynamic d)
        {
            Console.WriteLine(d.Shoot);
        }
    }
}
```


![](http://4.bp.blogspot.com/_CvP3b8RZYyc/SvAycn_HdWI/AAAAAAAAABc/TnNEbhHHSpE/s320/scary.jpg)




#### Scared!?

How would the previous code work?

Well, you would say that this code wouldn't compile because the static method "Main" is calling an instance method "DoSomething", right?

Wrong! This code will actually compile!! Yes, it will fail at runtime, but let's say why this piece of code behaved so freakingly scary. First let me show you another example:

```csharp
using System;
using System.Dynamic;

namespace DynamicDemo
{
 class Program
 {
   static void Main(string[] args)
   {
     dynamic d = new ExpandoObject();
     d.Shoot = "Booom!";
     DoSomeThing(d);
   } 
 }
}
```

Unlike the first example, this last example will not compile. All of this is related to how C# resolves method overloads.

If you examined section 7.5.4.1 of the C# 3.0 specification, you will learn about the Overload Resolution mechanism that C# follows, here's the steps in short:

Each overload is examined, and the best overload is selected according to the arguments.C# determines whether the overload is accessible from the current instance or static context.If the overload selected from step 1 is not accessible then a compile-time error is thrown.This overload resolution is done through compilation, but with dynamic, overload resolution is delayed until runtime, and it happens in the very same way as the above three steps (but at runtime of course).
So, at the first sample, the runtime has found the best overload to be the instance method "DoSomething" and then, determined that the selected target is not accessible for that call --as it's not accessible for static calls-- so the runtime threw a RuntimeBinderException exception.

For the second sample code, with no dynamic, the compiler finds out that "DoSomething" doesn't exist in the current context, so it will generate a compile-time error.

If you want to learn more about Overload Resolution, read the [C# Specification](http://msdn.microsoft.com/en-us/library/aa691336(VS.71).aspx).

Do you think this was scary enough, or am I being just too coward?
