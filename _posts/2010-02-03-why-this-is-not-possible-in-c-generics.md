---
layout: post
title: Why this is not possible in C# Generics?
date: '2010-02-03T19:39:00.000+02:00'
author: Galilyou
tags:
- C#
- Generics
modified_time: '2010-05-07T21:38:12.126+03:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-4791989053411780561
blogger_orig_url: http://www.galilyou.com/2010/02/why-this-is-not-possible-in-c-generics.html
---

A colleague pointed me to a strange case in C# (not so sure if this actually strange though). 
Suppose you have a class Employee. If you want to create a Generic List<> of type Employee, you can simply do:

```csharp
List<Employee> x = new List<Employee>; 
```
I understand that I need to pass the Employee type to the Generic list so that it knows the required type information about Employee and generates methods that return and accept parameters that are compatible with Employee. Now my question is, why isn't it possible to do the following? 

```csharp
Employee x = new Employee(); 
List<typeof(x)> list = new List<typeof(x)>(); 
```

Shouldn't this suffice the information required for List<> to know, in order to create a list? In other words, the type of x which is the type of Employee is now passed as a generic type parameter to List<>, which (as I used to believe) is the same as passing list the type name (in this case Employee). I wondered so, I posted a <a href="http://stackoverflow.com/questions/2192876/why-this-is-not-possible-in-c-generics">question </a>on <a href="http://stackoverflow.com/">Stackoverflow</a>.
If you're lazy enough to check the question, here's my selected answer, and boy it was submitted by Jon Skeet himself:typeof(x) doesn't work in C# either to get the type of a variable - it returns a Type reference for the&nbsp type name, e.g. will return a reference to the Type System.String type. That's equivalent to using String.class in Java. (Note that again, that's applying .class to a type name, not</em> a variable name.)

Java generics don't support anything like your final statement either. If you believe they do, please give a sample :)What you can</em> do in C# is use type inference to do what you want: 


```csharp
public static List<T> CreateListForSampleType<T>(T sample) 
{ 
    return new List<T>(); 
} 
... 
Employee x = new Employee(); 
var list = CreateListForSampleType(x); 
```
Note that there's no reason why C# couldn't be extended to allow something like ```typeof(variablename)```, ```List<typeof(variablename)>``` - it's all compile-time type information, after all. However, I can't see that it would meet the team's requirements for usefulness... there are other far more useful features I'd like to see first :) 
