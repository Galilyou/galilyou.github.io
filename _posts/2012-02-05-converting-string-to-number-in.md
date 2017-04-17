---
layout: post
comments: true
permalink: "/blog/js-string-to-number"
title: 'Converting String to Number in Javascript: A Gotcha'
date: '2012-02-05T17:46:00.000+02:00'
---

If you are used to programming in C, Java, or any similar language, you might get surprised by the way Javascript's  [parseInt](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/parseInt) and [parseFloat](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/parseFloat) functions work.


By its name, ```parseInt``` will convert a string into a number. It does so by reading through the string and converting the characters, one by one, to numbers,  until it meets an invalid character; it then stops and returns the read characters --the valid part-- as a number, ignoring the remaining.


This means that trying to convert an invalid string representation of a number to a number in javascript may not result in an error. For example ```parseInt("123ax4")``` will return 123.

This is a very different behavior from how Java, or C, or many other languages would work. Most other sane languages would throw errors if you try to do that. So, if like me, you think this is dangerous, then there is a better and *safer* way to do it.

##### Enter The Unary ```+``` Operator.

Using the unary [+ operator](https://developer.mozilla.org/en/JavaScript/Reference/Operators/Arithmetic_Operators#.2B_(Unary_Plus))  to convert strings to numbers guarantees you that either the entire string is a valid number, in such case the converted number value is returned as a result of the expression, or if there is any invalid number in the string, [NaN](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/NaN) is returned. So the output of the statement ```+ "123";``` results in the integer value 123. The output of the statement ```+ "123a";``` is NaN.