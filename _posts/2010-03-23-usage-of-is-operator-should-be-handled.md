---
layout: post
comments: true
title: Usage Of The "is" Operator Should Be Handled With Care
date: '2010-03-23T13:14:00.000+02:00'
author: Galilyou
tags: 
modified_time: '2010-06-02T12:13:03.229+03:00'
blogger_id: tag:blogger.com,1999:blog-5568328146032664626.post-6790009086968412079
blogger_orig_url: http://www.galilyou.com/2010/03/usage-of-is-operator-should-be-handled.html
---

C# provides means to explicitly cast from a type to another type. If you want to cast from float to int you can use the (int) cast operator to acheive that. This operator simply says to the compiler, I know you don't like this, but, please let the runtime try to do the cast. This operation can either succed or result in an System.InvalidCastException to be thrown. 

In addition to this, you can overload the explicit cast operator in case you wanted the cast to happen by your own defined rules. Ok let's see an example of this. Suppose that we have two types, Human and Employee, and in our very unfair world, an Employee is not a Human! The layout of these two classes might look like this: 

``` csharp
public class Human 
{
    public string Name { get; set; }       

}

public class Employee 
{
    public string Name { get; set; }

    public string Job { get; set; }

    public override string ToString()
    {
        return string.Format("Employee: {0} is {1}", Name, Job);
    }
}
```

Now let's say that you want to support an explicit custome conversion from Humans to Employees -for a fictious rule, let's say that every human is unemployed employee. The human class after adding the conversion operator should look like this: 

```csharp

public class Human
{
    public string Name { get; set; }
    public static explicit operator Employee(Human h)
    {
        return new Employee()
        {
            Name = h.Name,
            Job = "Happily Unemployeed"
        };
    }
} 
```

You can now try to cast your Humans to Employees, and see if the cast is really applying your rules, here's how I might attempt to cast one of humans to employee: 

``` csharp

Human h = new Human {Name = "John"}; 
Employee s = (Employee) h;
Console.WriteLine(s);
```

If you run this code you should see the output on the console screen saying: 

*Employee John is Happily Unemployeed.*

Now let's see how this plays with the famous "is" operator. The is operator is binary operator with a return type of boolean. What it does, is that it checks to see if the left hand operand is actually of the same type of the right hand operand -By the same type here, I mean, the same as an instance of the same class, or an instance of a derived class, or an instance of a class the implements the right hand operand in case the right hand operand is an interface. 

Here's a simple example to see this operator in action: 

```csharp

bool shouldBeTrue = "Hello" is string; // true
bool shouldBeTrueToo = "Hello" is object; // true
bool shouldBeFalse =  "Hello" is ICollection; // false
```

Now, the interesting part: 

```csharp

bool shouldBeWhat = new Employee() is Human; // ?? guess guess

```

Pause a minute and think of the above statement. What should the value of "shouldBeWhat" be? True of False? ... 

OK, the value of the boolean variable "shouldBeWhat" will actually be false. Yes, Employees are not Humans! Even though you have provided an explicit cast rule that , by the virtue of its existence, states that humans can be employees. "can be" doesn't equal to "is", does it? So, yeah the is operator doesn't take in account your explicit casting operators. So this is the first gottcha! 

The second point I wanna mention is that, the "is" operator works by actually performing a cast. Yes it casts and checks if the cast succedes it returns true otherwise, it returns false. A typical usage of the is operator is probably as follows: 

```csharp

if(h is Employee)
{
    var x = ((Employee) s).Job;
}
```

This should look familiar to you, a typical pattern when using the is operator is by checking first if a variable is of a given type, then if it is, cast it to that given type and use it. How many casts does the above code segment contain? 2 is the answer! Yes two, one is obvious in the statment

```csharp

var x = ((Employee) s).Job; 

```
and the other one is, yeah you guessed it, the cast performed by the is operator. This is not very ideal, as it simply, adds an overhead of a second cast which should is not necessary. So, what should you do to avoid that second cast?

##### Use "as" instead of "is":

The "as" operator allows you to do safe casts and aslo avoid the probability of throwing any InvalidCastException, by assigning null to the variable if the cast failed. The following segment is semantically equivalent to the previous segment, but is considered faster and safer:

```csharp

var x = h as Employee;
if(x != null)
 string job = x.Job;

```

The above segment is faster because it includes only one cast. 

Conclusion: 
There's not much to say here, just deal with the is operator carefully, and if possible avoid it and use the better alternative "as" operator.