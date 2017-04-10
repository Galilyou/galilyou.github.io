---
layout: post
title: C# 4.0 Now Consumes Indexed Properties
date: '2009-11-03T13:55:00.000+02:00'
author: Galilyou
tags:
- C#
- C#4.0
modified_time: '2010-03-10T19:30:05.983+02:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-5310131863691552875
blogger_orig_url: http://www.galilyou.com/2009/11/c-40-now-consumes-indexed-properties.html
---

If you dealt with COM Interop before, then you probably know what Indexed Properties mean. If you don’t, hang on with me and you will know in the coming few lines. Consuming Indexed Properties is a new feature to C# 4.0 Beta2. This is used to improve syntax like the following:
```csharp
var excel = new Microsoft.Office.Interop.Excel.ApplicationClass();
excel.get_Range(“A1”);
```
This syntax can now be improved to get rid of get_Range(“A1”) and use an indexer accessor instead, here’s how C# 4.0 Beta 2 can do for you to improve this:
```csharp
var range = excel.Range[“A1”];
```
So now, every time you use COM Interop and have to call get_x() and set_x(), you can now replace this with the new indexer syntax. I have to tell you –Well, you might have guessed it- that this is just a syntatic sugar, the compiler will do emit calls to get_x() and set_x() ultimately.

I think this little syntax improvement is pretty neat, however, people shouldn’t ask the very expected question “Well, now we can consume indexed properties in c#, why can’t we create it? we wanna create indexed properties! Indexed properties is a legal right! blah blah .. “. If C# allowed us to create indexed properties then I think, this will add an ambiguity that isn’t worth anything here. I mean take a look at the following code and tell me what would it mean to you, if C# enables you to create indexed properties?
```csharp
obj.SomeProperty[1]
```
Does it mean that SomeProperty is a type that implements an indexer, or SomeProperty is a property that requires an indexer? See the ambiguity?



What’s your thoughts on this, dear reader?