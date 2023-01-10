---
layout: post
use_mathjax: true
title: Output Formatting In Python
date: 2023-01-01 08:00:00 +0100
categories: [research]
excerpt: A brief elaboration on various approaches to output formatting in Python.
---

# Motivation

In this post, I would like to cover various ways of handling **output formatting** in [Python](https://en.wikipedia.org/wiki/Python_(programming_language)). Despite the fact that the topic of **printing** is one of the most fundamental ones, I have to admit that it does not cease to amaze me how the routine work of printing output can be enhanced with new [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) releases. In light of this, my endeavor is to highlight some key aspects I consider relevant with a **huge time-saving potential** when it comes to working with output (e.g., during debugging).

> **Mastery** of **`string` formatting** yields **efficiency**.

*Disclaimer: This article is by no means an exhaustive elaboration of output formatting. It serves merely as a basis for inspiration (and personal brain dump obviously) and further individual research into specific topics of interest.*

# C-style Strings

**C-style strings** are the most **basic approach**, and perhaps the **most limited one**. As the name suggests, it reflects the formatting patterns developed as part of the [C programming language](https://en.wikipedia.org/wiki/C_(programming_language)).

It is the **oldest method** of `string` formatting that relies on the use of **modulo** (`%`) **operator**.

> **C-style strings** are **basic** and **limited approach**, practically **obsolete** nowadays.

Here are several examples.


```python
first_name = "Guido"
last_name = "van Rossum"
age = 66

print("%s %s is %d years old." % (first_name, last_name, age))
```

    Guido van Rossum is 66 years old.



```python
year_length = 365.242196

print("The year is %.8f days long." % year_length)
```

    The year is 365.24219600 days long.


It's important to note that the **`string` formatting operator** shown above requires `tuple` as an argument. So, when printing the contents of a single `tuple`, one has to be extra careful.

> The **`string` formatting** (`%`) **operator** requires `tuple` as an **argument**.

Consider the following example.


```python
fibonacci_seq = (1, 1, 2, 3, 5, 8)

print("Fibonacci sequence %s." % fibonacci_seq)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    Cell In[4], line 3
          1 fibonacci_seq = (1, 1, 2, 3, 5, 8)
    ----> 3 print("Fibonacci sequence %s." % fibonacci_seq)


    TypeError: not all arguments converted during string formatting


Since the operator **expects** a `tuple`, it, therefore, tries to print `len(fibonacci_seq)` elements instead of just one.

To address this, an ugly fix like the one below would work...


```python
print("Fibonacci sequence %d, %d, %d, %d, %d, %d." % fibonacci_seq)
```

    Fibonacci sequence 1, 1, 2, 3, 5, 8.


The **disadvantages** are obvious, the most notable one being **violating** the [Don't-Repeat-Yourself (DRY)](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) **principle**.

To remedy this, the `tuple` needs to be **enclosed** into another `tuple` to make it work.


```python
fibonacci_seq = (1, 1, 2, 3, 5, 8)

print("Fibonacci sequence %s." % (fibonacci_seq,))
```

    Fibonacci sequence (1, 1, 2, 3, 5, 8).


The aforementioned **C-style strings** have become **obsolete** and I would **advise against adopting it in new codebases**. In what follows, I'll cover more "comfortable" ways to handle printing output.

# Using the "format" Method

Introduced in [PEP 3101](https://peps.python.org/pep-3101/), the `format` method of the `string` class is a **new way** of defining **output format**. The modern `f-string`s that will be covered later are more or less a [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar) for the concepts outlined below.


```python
first_name = "Guido"
last_name = "van Rossum"
age = 66

print("{} {} is {} years old.".format(first_name, last_name, age))
```

    Guido van Rossum is 66 years old.



```python
year_length = 365.242196

print("The year is {:.8f} days long.".format(year_length))
```

    The year is 365.24219600 days long.


Just for the record, **formatting floating point** values (i.e., `float`s) provides a lot **more options**, since its general **format specification** is 

```
{[index]:[width][.precision][type]}
```

On top of all this, the values to be printed can be passed as a `dict` where the **keys** are the **identifiers**, serving some sort of a **template** mechanism.


```python
print(
    "{firstname} {lastname} is {age} years old.".format(
        firstname=first_name, lastname=last_name, age=age
    )
)
```

    Guido van Rossum is 66 years old.


The `dict`-based parameters come in handy in the face of possible **duplicity**, e.g., when **violating** the already mentioned [Don't-Repeat-Yourself (DRY)](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) **principle**. The **same argument** can thus be **reused** at **multiple places**.

> The `format` method also **accepts** a `dict` of values to print, thereby allowing **reusability**.


```python
year_length = 365.242196

print(
    "The year does not have just {n_days:.0f} days, but {n_days:.6f} days exactly!".format(
        n_days=year_length
    )
)
```

    The year does not have just 365 days, but 365.242196 days exactly!


# Modern So-called "f-strings"

## Basic usage

Long story short, `f-strings` are pretty much an extension that makes calling the `format` method easier. It relies on the use of a **single** `f` **character** at the **beginning** of the **format string**.
More specifically, this feature was introduced in [PEP 498](https://peps.python.org/pep-0498/) as a **new string formatting mechanism** dubbed **Literal String Interpolation**.

> `f-strings` are also known as **Literal String Interpolation**.

> `f-strings` are a [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar) for the `format` method.


```python
first_name = "Guido"
last_name = "van Rossum"
age = 66

print(f"{first_name} {last_name} is {age} years old.")
```

    Guido van Rossum is 66 years old.



```python
year_length = 365.242196

print(f"The year is {year_length:.8f} days long.")
```

    The year is 365.24219600 days long.


As for me, the **conciseness** of the `f-strings` is literally incontrovertible.

> `f-strings` are a **manifestation** of **brevity** in conjunction **explicitness**.

## Formatting - under the hood

*Note: The upcoming discussion also applies to the `format` method we touched upon previously.*

In the case of having to **define custom formatting** rules, the `__format__` method can be **overridden**. The **argument** that is **specified after the colon** (`:` character) is provided as a **method parameter**. 

> **Custom formatting rules** can be **defined** within the `__format__` method.

The **parameter** is of `str` type and is **empty** if **no format** is specified.



```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __format__(self, spec):
        if not spec:
            return self.name
        elif spec == "full":
            return f"{self.name} ({self.age})"
        else:
            raise ValueError(
                f"unrecognized format, expected empty of `full`, got {spec}"
            )

person = Person("Guido von Rossum", 66)

print(f"{person}")
print(f"{person:full}")
```

    Guido von Rossum
    Guido von Rossum (66)


## Other object representation-related methods

Please, beware that the `print` function calls `__repr__` by default, so `print(person)` would **not invoke** the `__format__` method in the above example. That's why `print(f"{person}")` had to be used instead.

> The trio of **object string representation methods** consists of `__repr__`, `__str__`, and `__format__`, where each serves for a **completely different purpose**.

*Note: A deeper elaboration is out of the scope of this article, so I encourage the reader to explore the topic further by themselves.*

This is what happens if the `__repr__` method is not overrridden (which, in our case, is not).


```python
print(person)
```

    <__main__.Person object at 0x7f19082d3dc0>


The `__repr__` method can be called **directly** using the `!r` format modifier.


```python
print(f"{person!r}")
```

    <__main__.Person object at 0x7f19082d3dc0>


And here is an attempt to **invoke** the `__str__` method of the object, again, demonstrating the **default behavior** as the implementation is **missing** in our example.


```python
print(f"{person!s}")
```

    <__main__.Person object at 0x7f19082d3dc0>


Let's then **define** **custom** `__str__` and `__repr__` methods to see the difference. A short sidenote, the `__repr__` method is **reserved** for **string representation** of the **object** itself. It should be possible to **construct** the object from its **string representation** if the **expression** is evaluated (e.g., using the `eval` built-in function). In a math-like fashion, one could claim that `assert eval(object_instance.__repr__()) == object_instance`, assuming that the `__equals__` method is properly overridden.


```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __str__(self):
        return f"{self.name}, {self.age} years old"
    
    def __repr__(self):
        return f"{__class__.__name__}({self.name!r}, {self.age!r})"

person = Person("Geoffrey Hinton", 75)

print(person)
print(f"{person!s}")
print(f"{person!r}")
```

    Geoffrey Hinton, 75 years old
    Geoffrey Hinton, 75 years old
    Person('Geoffrey Hinton', 75)


To demonstrate the **purpose** of the `__repr__` method, the expression it produces should be **sufficient** to construct the object **from scratch** when **evaluated** (using `eval`), so...


```python
person_new = eval(person.__repr__())

print(person_new)
print(f"{person_new!s}")
print(f"{person_new!r}")
```

    Geoffrey Hinton, 75 years old
    Geoffrey Hinton, 75 years old
    Person('Geoffrey Hinton', 75)


## Advanced formatting

This section covers some **advanced** formatting examples that may significantly **enhance** the **output quality** as well as **save** considerable amount of **time** when **debugging**.

### Explicit ASCII representation

Every now and then, primarily when **debugging**, it might be useful to obtain the exact [ASCII](https://en.wikipedia.org/wiki/ASCII) representation of the `string`, especially when it contains [UNICODE](https://en.wikipedia.org/wiki/Unicode) characters. To this end, there is the `!a` **format modifier**.


```python
card_suits = "diamonds (♦), clubs (♣), hearts (♥) and spades (♠)"

print(f"{card_suits}")
print(f"{card_suits!a}")
```

    diamonds (♦), clubs (♣), hearts (♥) and spades (♠)
    'diamonds (\u2666), clubs (\u2663), hearts (\u2665) and spades (\u2660)'


### Expression Representation

When **debugging** or implementing a **logging output** (e.g., using the [`logging`](https://docs.python.org/3/library/logging.html) module), one may often wish to **print** the **value** of some **variable** together with its **name**, as shown below.


```python
total = 10

print(f"total = {total}.")
```

    total = 10.


When the **name** of the variable `total` changes, the **output** above is **no longer valid**. Nowadays, **refactoring** tools, even in [dynamically typed languages](https://en.wikipedia.org/wiki/Dynamic_programming_language) such as [Python](https://en.wikipedia.org/wiki/Python_(programming_language)), are able to handle **variable renaming** reasonably well. However, these tools would have hard time figuring out that the `"total = "` text is also associated with the variable name. Consequently, one has to update the output statement accordingly, engaging in duplicite work that we should strive to avoid in the first place.

A **new formatting specification** comes to the rescue with **Python 3.8** and above. The syntax speaks for itself, at least for me....


```python
print(f"{total=}.")
```

    total=10.


The **compactness** is simply staggering.

> The `f"{var=}"` **format** ties the **`string` representation** of the **expression** with its **value**.

Moreover, it allows to **specify spaces** as well, in order to match our initial output exactly.


```python
print(f"{total = }.")
print(f"{total= }.")
print(f"{total =}.")
```

    total = 10.
    total= 10.
    total =10.


But that's not all. As suggested above, it is the **`string` representation** of the **expression**, not just the **variable name**, that gets printed. Furthermore, all the **formatting options** discussed so far can be applied, too.

All right, as [Linux Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) succintly remarked that *"Talk is cheap. Show me the code."*, let's have a look at more capabilities of this fabulous feature. 


```python
print(f"{total = }")
print(f"{total // 3 = }")
print(f"{total / 3 = :.6f}")
print(f"{total % 3 = }")
print(f"{(total // 2) ** 2 = }")
```

    total = 10
    total // 3 = 3
    total / 3 = 3.333333
    total % 3 = 1
    (total // 2) ** 2 = 25


### Printing date and time information

Another useful example how `f-strings` might be beneficial is when printing **date** and **time** information.


```python
import datetime

curr_time = datetime.datetime.now()

print(f"Today's date is: {curr_time:%d/%m/%Y}.")  # Day, month, and year.
```

    Today's date is: 10/01/2023.


# Templates

To me, a somehow **less known** way to specify **output format** is to **define** a **template**, as proposed in [PEP 292](https://peps.python.org/pep-0292/). The format exploits **placeholder names** indicated by the dollar sign (`$` character) conforming to the rules of [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) identifier naming, i.e., alphanumeric characters including underscores, concretely `0-9a-zA-Z_`. As the **common practice** dictates, writing `$$` signifies **escaping** to the parser, thus producing just a single `$` on the output.


```python
from string import Template

template = Template(
"""Hey, $first_name $last_name. How old are you?
I am $age years old. Why are you asking?"""
)

print(template.substitute(first_name="Donald", last_name="Knuth", age=84))
```

    Hey, Donald Knuth. How old are you?
    I am 84 years old. Why are you asking?


# Conclusion

In this post, I tried to provide brief introduction to **output formatting** in [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) with focus on **usefulness** and **inspiration** rather than exhaustive elaboration of details. In the context of `string` formatting, this language has a great deal of built-in capabilities that evelopers should exploit instead of re-inventing the wheel or perofrming duplicite tasks in their day-to-day programming workflow.

I hope you learned something new.
