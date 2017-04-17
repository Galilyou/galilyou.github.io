---
layout: post
comments: true
permalink: "/blog/operations-vs-methods"
date: '2009-11-11T11:09:00.000+02:00'
author: Galilyou
tags:
- UML
- OOD
modified_time: '2009-11-11T12:58:43.445+02:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-6209596458542052741
blogger_orig_url: http://www.galilyou.com/2009/11/quick-tip-operations-are-not-methods.html
---

In the industry of software development people always use the terms Operation and Method interchangeably. Often time this is true, other times it's not!
To begin let's define what the two terms exactly mean --in terms of Object Oriented Design?

[From <a href="http://www.martinfowler.com/bliki/">Fowler's</a> <a href="http://www.amazon.com/UML-Distilled-Standard-Modeling-Language/dp/020165783X">UML Distilled</a>]

<b>Operation:</b>
      An operation is something that is invoked on an object --the procedure declaration.
<b>Method:</b>
    A method is the body of the procedure.
I guess it's obvious how related and close the two terms are. But sometimes they can be quite different.
For example if you have A super class Employee that defines an abstract operation Work() and 3 sub classes of Employee (Manager, Programmer, and SalesRep) that override the inherited operation Work() then in this case you have 1 operation and 3 methods. 1 defined operation in the base class and 3 different implementations.