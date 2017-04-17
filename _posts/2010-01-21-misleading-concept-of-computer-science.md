---
layout: post
comments: true
permalink: "/blog/dynamic-programming"
title: 'A Misleading Name of Computer Science Concept: Dynamic Programming'
date: '2010-01-21T15:22:00.000+02:00'
author: Galilyou
tags:
- Algorithms
- dynamicProgramming
modified_time: '2010-02-01T13:09:00.084+02:00'
---

Have you heard of these words before?
Probably yes!
First let's make a clear (well, not so clear) difference, clearer. Dynamic Programming is not about Dynamic Typing. Dynamic typing is a property of  a particular programming language. Languages like Lisp, Python, and Ruby are all dynamically typed languages. Unlike those, languages like C/C++, Java, and C# are statically typed language. The difference relies on whether the compiler checks certain things (types, overload resolution, etc.)  before running the program or not.
Dynamic Programming on the other hand is something very different. It's an ancient method for solving problems by basically dividing these problems into smaller, and easier to solve problems.

It's mainly focused on addressing these two issues:

<ol><li>Overlapping subproblems </li><li>Optimal Substructures</li></ol><div>I think the best way to explain these two fuzzy concepts is by using examples. To start let's see an example of using a famous dynamic programming technique called  Memorization. Assume that we need to implement a function that calculates a <a href="http://en.wikipedia.org/wiki/Fibonacci_number">Fibonacci </a>sequence. I know this is easy, but let's look at this first implementation:</div>

```csharp
static int FibClassic(int n, ref int numberOfStepsTaken)
{
    numberOfStepsTaken += 1;
    if (n &lt;= 1)
        return 1;
    Console.WriteLine("FibClassic called with: {0}", n);
    return FibClassic(n - 1, ref numberOfStepsTaken) + FibClassic(n - 2, ref numberOfStepsTaken);
}
```
Note: on the above code I used two counter variables to count the number of times the method executed. I also printed the input on which the method is called every time, just to give you a hint of how dividing a problem can cause the same subproblem to be computed more than once --Subproblem Overlapping, remember! Now let's run the code given the number 6 as input and see what happens:

```csharp
int z = 0;
int x = FibClassic(6, ref z);
Console.WriteLine("{0}: {1}", x, z);
```
<div class="separator" style="clear: both; text-align: center;">
</div>And here's the result of this call:
<div class="separator" style="clear: both; text-align: center;"><a href="http://4.bp.blogspot.com/_CvP3b8RZYyc/S1hWDUQQtZI/AAAAAAAAAE8/NVWnG9ZMkXA/s1600-h/output.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="320" src="http://4.bp.blogspot.com/_CvP3b8RZYyc/S1hWDUQQtZI/AAAAAAAAAE8/NVWnG9ZMkXA/s640/output.png" width="640" /></a></div>
As you can see the method has been called first with input 6 which is the initial input we passed in, then 5, 4, 3,  2, 2, ... oops!! Can you spot it? the method is being called on the same input more than once! Think about this for a while, pretty logical, yeah!? Our strategy is based on dividing the problem into simpler subproblems. For example to get the 6th item in the Fibonacci sequence we divide the problem into two smaller problems, getting the 5th item, and 4th item and adding them together, then to get the 5th, you should get the 4th and 3rd, etc. The next figure shows how is this working.

<div class="separator" style="clear: both; text-align: center;"><a href="http://3.bp.blogspot.com/_CvP3b8RZYyc/S1hV0VZHvcI/AAAAAAAAAE0/dbF7i0TzTYY/s1600-h/tree.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="196" src="http://3.bp.blogspot.com/_CvP3b8RZYyc/S1hV0VZHvcI/AAAAAAAAAE0/dbF7i0TzTYY/s400/tree.png" width="400" /></a></div>
<div class="separator" style="clear: both; text-align: center;">
</div>As you notice the overlapping happens when solving one part of the problem includes solving another part of the problem, in such a case we can take advantage of this and simply memorize the solution for the overlapped problem and each time we need that result, we don't have to compute it again, we just supply it from wherever we stored it. Here's the modified method to do it:


```csharp
static int FibFast(int n, ref int numberOfStepsTaken, Dictionary<int, int=""> store)</int,>
{
    numberOfStepsTaken += 1;
    if (n &lt;= 1)
        return 1;
    if (!store.ContainsKey(n))
        store[n] = FibFast(n - 1, ref numberOfStepsTaken, store) + FibFast(n - 2, ref numberOfStepsTaken, store);
    return store[n];
}
```
If you run that same method on the same input (6) you should get 13 as the result (the same old result) but the number of iterations would be 11 which is about half the number of iterations the first method take. This doesn't seem to be a very huge enhancement, but let's see how the two methods act for bigger numbers.  Running the first method of input equals to 30 we get the result  1346269 and number of iterations  2692537. Now running the second method on the same input (30) we get the result 1346269 -which is the same result- and number of iterations 59!  That's a <b>HUGE </b>difference!

<b>Now back to core, what does this have to do with the term Dynamic Programming??</b>
<i><b></b></i><i><span class="Apple-style-span" style="color: blue;">Actually, it's a very misleading term, historically it was invented by a mathematician called </span><b><span class="Apple-style-span" style="color: blue;">Bellmen </span></b><span class="Apple-style-span" style="color: blue;">and he was at the time being paid by the US defense department to work on something else. He didn't want them to know what he was doing, so he made up  a name that he was sure it has no clue what it actually meant. Now we have to live with this forever :)</span></i>