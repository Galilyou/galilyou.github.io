---
layout: post
title: 'Back to Basics: Square Root Implementation in Python and C# (Newton''s Method)'
date: '2009-12-30T14:34:00.000+02:00'
author: Galilyou
tags:
- square roots
- C#
- python
- math
modified_time: '2009-12-30T14:42:41.226+02:00'
thumbnail: http://1.bp.blogspot.com/_CvP3b8RZYyc/SztKnW1-8FI/AAAAAAAAACc/tqx_5nk2EJ8/s72-c/isaac_newton.jpg
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-1341442234138685575
blogger_orig_url: http://www.galilyou.com/2009/12/back-to-basics-square-root_30.html
---

In my last <a href="http://galilyou.blogspot.com/2009/12/back-to-basics-square-root.html">post</a>&nbsp;I introduced to you an extra simple algorithm to calculate square roots, it's called the Bi Section method. The Bi (pronounced by) part comes form the word binary. This is due to the fact that each time we pick a guess we pick it at a point in the middle between an upper bound and a lower bound. This technique is very useful in many cases in computer science (e.g. Binary Search is a very famous example of that).

As you see the Bi Section method is really simple, however, it's not that effective.
This time I will introduce a different method to calculate square roots, this method is called "<span style="font-family: verdana, arial, helvetica, sans-serif; font-size: small;">Newton-Raphson's method", it's named after <a href="http://en.wikipedia.org/wiki/Isaac_Newton">Issac Newton</a>, and <a href="http://en.wikipedia.org/wiki/Joseph_Raphson">Joseph Raphson</a>.</span>
<div class="separator" style="clear: both; text-align: center;"><a href="http://1.bp.blogspot.com/_CvP3b8RZYyc/SztKnW1-8FI/AAAAAAAAACc/tqx_5nk2EJ8/s1600-h/isaac_newton.jpg" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://1.bp.blogspot.com/_CvP3b8RZYyc/SztKnW1-8FI/AAAAAAAAACc/tqx_5nk2EJ8/s320/isaac_newton.jpg" /></a>
</div><span style="font-family: verdana, arial, helvetica, sans-serif; font-size: small;">
</span>
<span style="font-family: verdana, arial, helvetica, sans-serif; font-size: small;">This method is known to be really effective --especially when the initial guess is near from the correct answer-- and it's considered to be <i>the&nbsp;</i><span style="font-family: sans-serif; font-size: 13px; line-height: 19px;"><i>&nbsp;best known method for finding successively better approximations to the zeroes (or&nbsp;</i><a href="http://en.wikipedia.org/wiki/Root_of_a_function" style="background-attachment: initial; background-clip: initial; background-color: initial; background-image: none; background-origin: initial; background-position: initial initial; background-repeat: initial initial; color: #002bb8; text-decoration: none;" title="Root of a function"><i>roots</i></a><i>) of a&nbsp;</i><a href="http://en.wikipedia.org/wiki/Real_number" style="background-attachment: initial; background-clip: initial; background-color: initial; background-image: none; background-origin: initial; background-position: initial initial; background-repeat: initial initial; color: #002bb8; text-decoration: none;" title="Real number"><i>real</i></a><i>-valued&nbsp;</i><i><a href="http://en.wikipedia.org/wiki/Function_(mathematics)" style="background-attachment: initial; background-clip: initial; background-color: initial; background-image: none; background-origin: initial; background-position: initial initial; background-repeat: initial initial; color: #002bb8; text-decoration: none;" title="Function (mathematics)">function</a>.&nbsp;</i></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">Explaining this method will require a certain amount of familiarity with Calculus and Algebra, so I'm not going to delve into this here. However, I will show you the code to do it in Python and C# (which, surprisingly you will find very simple).&nbsp;</span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">
</span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">First, the code in Python:

</span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">

```python
def sqrtWithPrecisonNR(x, precision):   
    assert x >= 0, 'x must be non-negative, not' + str(x)
    assert precision > 0, 'epsilon must be positive, not' + str(precision)
    x = float(x)
    guess = x/2.0    
    diff = guess**2 -x
    ctr = 1
    while abs(diff) > precision and ctr <= 100:
        guess = guess - diff/(2.0*guess)
        diff = guess**2 -x
        ctr += 1
    assert ctr <= 100, 'Iteration count exceeded'
    print 'NR method. Num. iterations:', ctr, 'Estimate:', guess
    return guess

```
</span></span> <span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"> </span></span> <span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"> </span></span> <span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">Second, the code in C#:&nbsp; </span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"></span></span>
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">```csharp
float SqrtWithPrecisonNR(float x, float precision)
        {
            if (x < 0 || precision <= 0)
                throw new ArgumentException("x, and precission gotta be non negative numbers");
            float guess = x/2.0f;
            float diff = guess*guess - x;
            int counter = 1;
            while(Math.Abs(diff) > precision && counter <= 100)
            {
                guess = guess - diff/(2.0f*guess);
                diff = guess*guess - x;
                counter++;
            }
            if(counter > 100)
                throw new Exception("100 iterations done with no good enough answer");
            Console.WriteLine("Num of Iterations: {0} , estimate: {1}", counter, guess);
            return guess;
        }
```

Now, I want you to try this method with the <a href="http://galilyou.blogspot.com/2009/12/back-to-basics-square-root.html">last one</a> and see the difference. 
Here's a helper function that will test the two methods with input 2 as the root and 0.000001 precision: 



```python
def testMethods():
    sqrtWithPrecision(2, 0.000001)
    sqrtWithPrecisionNR(2, 0.000001)    
```
</span></span><span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">
You should see that the Newton's method is much faster and this difference in speed will be totally apparent when you try it on bigger numbers.
</span></span> <span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"> </span></span> <span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;"> </span></span> 
<span style="font-family: sans-serif; font-size: small;"><span style="font-size: 13px; line-height: 19px;">For more details about the Newton's method including the mathematical stuff see <a href="http://en.wikipedia.org/wiki/Newton's_method">here</a></span></span>