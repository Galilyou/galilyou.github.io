---
layout: post
comments: true
permalink: "/blog/classes-of-algorithms"
title: 'A Quick Tip: The Different Classes Of Algorithms'
date: '2010-01-14T16:23:00.000+02:00'
author: Galilyou
tags:
- Algorithms
modified_time: '2010-01-14T16:32:52.807+02:00'
---

Algorithms are the heart of computer science. They are the thoughts, the ideas, and the most fun part of this industry. Scientists categorize the various known algorithms into 4 classes: Logarithmic, Linear, Quadratic and Exponential. Let's look at those briefly:
1- Logarithmic Algorithms:
   This type is the fastest of those 4 classes. It has a run curve that looks something like this:

<div class="separator" style="clear: both; text-align: center;"><a href="http://1.bp.blogspot.com/_CvP3b8RZYyc/S08ebgdliaI/AAAAAAAAADk/doCvgOon5zA/s1600-h/x12-semi-log.gif" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://1.bp.blogspot.com/_CvP3b8RZYyc/S08ebgdliaI/AAAAAAAAADk/doCvgOon5zA/s320/x12-semi-log.gif" /></a>
</div>
<div class="separator" style="clear: both; text-align: center;">
</div>Where the x here is the number of items to be processed by the algorithm, and y is the time takes by the algorithm. As you can see from the figure, the time taken increases slowly when the number of items to be processed increase. Binary Search is a perfect example for a logarithmic algorithm. If you recall, binary search, divides the array into two halves and excludes one half each time it does a search. Here's a code example of binary search implementation in C#:

```csharp
bool BSearch(int[] list, int item, int first, int last)
{
 if(last - first < 2)
             return list[first] == item || list[last] == item;

        int mid = (first + last)/2;
        if(list[mid] == item)
             return true;

        if (list[mid] > item)
                return BSearch(list, item, first, mid - 1);

 return BSearch(list, item, mid + 1, last);
}
```

2- Linear Algorithms:
  Runs in time, linear to the input items. It's curve looks like the following:
<div class="separator" style="clear: both; text-align: center;"><a href="http://4.bp.blogspot.com/_CvP3b8RZYyc/S08i6pcYYyI/AAAAAAAAADs/sL9iubT27IY/s1600-h/linear.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/_CvP3b8RZYyc/S08i6pcYYyI/AAAAAAAAADs/sL9iubT27IY/s320/linear.png" /></a>
</div>

A linear search is a typical example of that, where one would traverse the array or, whatever data structure, item by item. An implementation of linear search looks like this:

```csharp
bool LinearSearch(int[] list, int item)
{
     for(int i = 0; i < list.Length; i++)
          if(list[i] == item)
              return true;
        return false;
}
```
3- Quadratic Algorithm:    This one runs time grows to to the power of 2, with each increase in the input sizes, which means while processing 2 items the algorithm will do 4 steps, 3 items will take 9 steps, 4 items will take 16 steps, etc. The next figure shows how a quadratic curve might look like:
<div class="separator" style="clear: both; text-align: center;"><a href="http://4.bp.blogspot.com/_CvP3b8RZYyc/S08j5CVWiGI/AAAAAAAAAD0/liMvQSqgBBU/s1600-h/quadratic.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/_CvP3b8RZYyc/S08j5CVWiGI/AAAAAAAAAD0/liMvQSqgBBU/s320/quadratic.png" /></a>
</div>
A famous example of an algorithm with quadratic growth is Selection Sort:

```csharp
void SelectionSrot(int[] list)
{
	int i, j;
	int min, temp;

	for (i = 0; i < list.Length - 1; i++)
	{
	    min = i;

	    for (j = i + 1; j < list.Length; j++)
	    {
	        if (list[j] < list[min])
	        {
	            min = j;
	        }
	    }

	    temp = list[i];
	    list[i] = list[min];
	    list[min] = temp;
	}
}
```

4- Exponential Algorithm:
This is the super slow of this list of four. It grows exponentially (that is, for 2 items it takes 2 ^ 2, for 3 items it takes 2^3, for 4 items it takes 2 ^ 4, etc.
Again algorithms are the key to computer science, the most fun part of programmer's  job. Choose your algorithms carefully and always try to improve.

Hope this helps.