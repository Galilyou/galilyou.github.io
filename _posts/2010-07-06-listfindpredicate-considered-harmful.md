---
layout: post
title: List.Find(Predicate <T>) Considered Harmful
date: '2010-07-06T12:26:00.000+03:00'
author: Galilyou
tags: 
modified_time: '2010-07-06T20:21:04.819+03:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-5829856647979998780
blogger_orig_url: http://www.galilyou.com/2010/07/listfindpredicate-considered-harmful.html
---

Hold on, it's not goto! 



I dare to say that every program have ever written on this entire planet needed some sort of searh functionality, and if it didn't, it's probably because it's too lame and frickin' uslelss. 



Today I was working on a piece of code that part of it is concerned about finding items in a generic List<T>. The code I wrote was some like this: 



```var products = ProductsCollection.Find(p => p.Price > 500);```

Doesn't that look concise and elegant. For me it does, the problem is, however, this code is **not SAFE** (yeah, i was surprised too). 



When I run this code I got a <a href="http://msdn.microsoft.com/en-us/library/system.nullreferenceexception.aspx">System.NullReferenceException</a>. WTF is that? ProductsCollection is totally a valid reference, however, it was empty.



OK, wait a second why should searching an empty list throw an exception? The expected result should be null or something but not an exception. After thinking about it a little, I thought, Oh, what if the list contains value types? In such case null is not a valid return type, so an exception makes sense to me now. 



Here I thought I really got it and understood that List.Find will throw a null reference exception if called on an empty list. I was totally wrong if you must know. The call would simply return default(T) which is null for reference types. The exception was actually thrown when I used the return of the find! 



Now I wondered "OK, now what if i'm searching a list that only contains value types and the item i'm searching for doesn't exist in that list? What would be the result in this case? Well, let's try it out":



```csharp
List<int> evens = new List<int> { 0, 2, 4, 6, 8, 10};

var evenGreaterThan10 = evens.Find(e => e > 10);

Console.WriteLine(evenGreaterThan10);
```

What the search returned in this case is the value 0, yes zero! because nothing in the list is greater than 10 so Find will just give you default(T). This can lead to some really nasty bugs. Don't curse, this is frickin' documented you lazy sloths.

#### Important Note

When searching a list containing value types, make sure the default value for the type does not satisfy the search predicate. Otherwise, there is no way to distinguish between a default value indicating that no match was found and a list element that happens to have the default value 

for the type. If the default value satisfies the search predicate, use the FindIndex method instead.


Trying to be safe in this case you could simply check after finding to see if the returned value is what you actually asked for, something like that: 



``` csharp
List<int> evens = new List<int> { 0, 2, 4, 6, 8, 10};

var evenGreaterThan10 = evens.Find(e => e > 10);

if(evenGreaterThan10 > 10)

{

   // valid value

}

else 

{

   // none found    

}

```

I'm not sure how do you feel about that, but for me, I really hate it! So what I ended up doing is something similar to the well known TryParse style, I overloaded the Find method with an extension method that would allow the usage to be something like this:



``` csharp
List<int> evens = new List<int> { 0, 2, 4, 6, 8, 10};

int i;

if(evens.Find(e => e > 6, out i))

  Console.WriteLine(i);

else 

  Console.WriteLine("None found");
```

The extension method is as simple as: 



``` csharp
public static bool Find<T>(this List<T> list, Predicate<T> predicate, out T output)

{

  output = list.Find(predicate);

  return predicate(output);

}
```

#### EDIT:

As reported by Kevin Hall in the comments, this method has a serious bug. Consider the following code segment: 

``` csharp
List<int> x = new List<int> { -10, -8, -6, -4 };

int myResult = -9999;

bool resultFound = x.Find(e => e > -3, out myResult);
```

In this case result found would be true and myResult would be zero! A yet better way to do this is by making use of the FindIndex method like so: 



``` csharp
public static bool Find<T>(this List<T> list, Predicate<T> predicate, out T output)

{

  int index = list.FindIndex(predicate);

  if (index != -1)

  {

    output = list[index];

    return true;

  }

  output = default(T);

  return false;

}

```

Thanks Kevin for pointing that out.

I'm much happier now, I can drop the suicide thought for a while! What do you think dear reader?