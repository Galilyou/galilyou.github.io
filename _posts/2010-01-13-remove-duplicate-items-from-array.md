---
layout: post
comments: true
title: Remove Duplicate Items From an Array - A Classic Puzzle
date: '2010-01-13T08:50:00.000+02:00'
author: Galilyou
tags:
- Algorithms
- puzzles
modified_time: '2010-01-17T13:34:19.930+02:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-6817291243805076028
blogger_orig_url: http://www.galilyou.com/2010/01/remove-duplicate-items-from-array.html
---

 Today I cam a cross a kinda cool problem. A friend of mine who is at the same time a colleague working with me at the same office was trying to remove a duplicate item from an array of positive integers.
 The array has n items all unique except only one item. We need to come up with an algorithm that tells us which item is duplicated in maximum time of
 O(n) where n is the length of the array.

 To do that, let's first come up with some (less efficient) working algorithms. Here's the first one:

 We loop over the array starting from the item at index 0, then we traverse the remaining part of the array (1 : n-1) searching for the first item
 The C# code for this algorithm looks like the following:

```csharp
static int FirstDuplicate(int[] arr)
{
 for(int i = 0; i < arr.Length - 1; i++)
 {
     for(int j = i + 1; j < arr.Length; j++)
     {
         if (arr[i] == arr[j])
             return arr[i];
     }
 }
 return -1;
}
```
 As you can see, this algorithm is pretty bad. Foreach item in the array an inner loop is initiated to linerally look for that specific element in the
rest of the array. If you do the math, you shall find that this algorithm runs in O(n2) order of growth.

One way to improve this is to use an extra HashSet to store the items, and then look up each item in the HashSet. This is considered improvement as the
lookup inside the HashSet is really fast.
Here's the code in C#:

```csharp
static int FirstDuplicateWithHashSet(int[] arr)
{
	HashSet<int> hashHset = new HashSet<int>();
	for(int i = 0; i < arr.Length; i++)
	{
	    if (hashHset.Contains(arr[i]))
	        return arr[i];
	    hashHset.Add(arr[i]);
	}

	return 0;
}
```
This is pretty good, but still not O(n).
The next algorithm is quite tricky. The idea simply is to create a second array and insert each elemnt in the first array at an index equivalent to its
value in the second array.
For example if we have a list of 5 items [2, 4, 5, 2, 6], where the item 2 is duplicated at the 0 index and third index, and the maximum value in this
array is 6. Now to find the duplicates in this list we create a second list with length 6 ( the length of the second array equals the maximum value in
the first array). After creating this second list we loop over the first array take the first item (2 in our case) and insert it at the index 2 in
the second array, then we take the second item (which is 4) and insert it at the 4th index in the second array, and so on. Each time we try to insert
an item in the second array we check if it has a value first, if it is, then this item is duplicated.
here's how the code would look like:

```csharp
static int FirstDuplicate(int[] arr, int maxVal)
{
    int[] temp = new int[maxVal+1];
    for(int i =0; i < arr.Length; i++)
    {
        if (temp[arr[i]] == arr[i])
            return arr[i];
        temp[arr[i]] = arr[i];
    }
    return 0;
}
```
 Note: The method expects the maximum value as an input, however, if you don't get the maximum value you can create the temp array with a size
 equal to  int.MaxValue (which is not a good idea)

 This algorithm is probably not realistic but it doesn run in O(n) time.
 One more trick to add here, if you know the range of the items in the array (e.g. from 1 to 10) you can get the sum of the numbers of the array
 then subtract from it the sum of the numbers from 1 to 10, the remainder is the duplicated value.

 That was a quick tip that I thought is cool and wanted to share with ya! So what do you think dear fellows? Do you know of any possibly better
 algorithms? Do you suggest any optimization to the current ones?