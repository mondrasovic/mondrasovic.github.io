---
layout: post
use_mathjax: true
title: Formula for expanding a^n - b^n.
date: 2021-05-04 10:00:00 +0100
categories: [math]
excerpt: In this post, I show how to derive a formula for expanding a^n - b^n.
---

Today, I came across the following formula:

$$
a^n - b^n = \left( a - b \right) \left( a^{n - 1} + a^{n - 2}b + a^{n - 3}b^2 + \dots + a^2b^{n - 3} + ab^{n - 1} + b^{n - 1} \right).
$$

Or, expressed more compactly:

$$
a^n - b^n = \left( a - b \right) \sum_{k = 0}^{n - 1} a^{\left( n - 1\right) - k} b^k.
$$

My immediate thought was to figure out how someone could have had come up with that formula in the first place. After pondering about it a little bit, I learned about the derivation described below.

Allegedly, one way to derive this expansion is to think about the sum of the geometric series. As a reminder, here we have the well-known formula for the sum of the first $$n$$ terms of geometric series:

$$
S_n = 1 + x + x^2 + x^3 + \dots + x^{n - 1} + x^{n} = \frac{1 - q^{n + 1}}{1 - q}.
$$

The key idea to producing the formula for expanding the expression $$a^n - b^n$$ is to derive the formula for the sum of geometric series since it mysteriously involves a similar-looking $$1 - x^n$$ term.

With this in mind, let's start. I will use the standard trick of having the original sum multiplied by $$x$$ and subtracted the resulting series from the original. To demonstrate, assume

$$
\begin{aligned}
&S = 1 + x + x^2 + x^3 + \dots + x^{n - 1},\\

&xS = x + x^2 + x^3 + \dots + x^{n - 1} + x^n.
\end{aligned}
$$

Now, subtracting the second equation from the first yields

$$
\begin{aligned}
&S - Sx = 1 + \left( x - x \right) + \left( x^2 - x^2 \right) + \dots + \left( x^{n - 1} - x^{n - 1} \right) - x^n,\\

&S - Sx = 1 - x^n,\\

&S \left( 1 - x \right) = 1 - x^n.
\end{aligned}
$$

When we substitute the value of $$S$$ into the last equation, we get

$$
\left( 1 + x + x^2 + x^3 + \dots + x^{n - 1} \right) \left( 1 - x \right) = 1 - x^n.
$$

At this point, our expression starts to become very similar to our ultimate goal stated at the beginning. However, there is still one more substitution to be done before pure algebraic manipulations come into place. Admittedly, I could not come up with this substitution quickly by myself. The truth is, I did not try for too long, but still, I feel that ideas of this type are one of my weaknesses. I reckon it takes a little bit of insight into the problem itself and a good deal of creativity. Nevertheless, for the sake of learning, I consider the solution to be generally applicable. Always keep asking yourself where you want to get in the end, whether it is proving a theorem or just solving a problem. Keep in mind that substitution is a reasonable approach to take. Remember how integration may be simplified using substitution. Speaking of integration, a change in coordinates comes to mind, too. Trigonometric equations are also often tackled with substitution. I remember that I have encountered many times how substitution did the trick. I look at this problem through a similar lens. So, what should we substitute for $$x$$, then? Think of it this way. We want to transform the expression $$1 - x^n$$ into $$a^n - b^n$$. Thus, let's go with $$x = \frac{b}{a}$$, which produces

$$\begin{aligned}
\left[ 1 + \frac{b}{a} + {\left( \frac{b}{a} \right) }^2 + {\left( \frac{b}{a} \right) }^3 + \dots + {\left( \frac{b}{a} \right) }^{n - 1} \right] \left( 1 - {\frac{b}{a}} \right) = 1 - {\left( \frac{b}{a} \right) }^n,\\

\left( 1 + \frac{b}{a} + \frac{b^2}{a^2} + \frac{b^3}{a^3} + \dots + \frac{b^{n - 1}}{a^{n - 1}} \right) \left( 1 - {\frac{b}{a}} \right) = 1 - \frac{b^n}{a^n}.\\
\end{aligned}$$

Now, multiply both sides of the last equation by $$a^n$$ and further manipulate the equality as follows:

$$\begin{aligned}
a^n \left( 1 - {\frac{b}{a}} \right) \left( 1 + \frac{b}{a} + \frac{b^2}{a^2} + \frac{b^3}{a^3} + \dots + \frac{b^{n - 1}}{a^{n - 1}} \right) = a^n - b^n,\\

\left( a^n - a^{n - 1}b \right) \left( 1 + \frac{b}{a} + \frac{b^2}{a^2} + \frac{b^3}{a^3} + \dots + \frac{b^{n - 1}}{a^{n - 1}} \right) = a^n - b^n,\\

a^{n - 1} \left( a - b \right) \left( 1 + \frac{b}{a} + \frac{b^2}{a^2} + \frac{b^3}{a^3} + \dots + \frac{b^{n - 1}}{a^{n - 1}} \right) = a^n - b^n,\\

\left( a - b \right) a^{n - 1}  \left( 1 + \frac{b}{a} + \frac{b^2}{a^2} + \frac{b^3}{a^3} + \dots + \frac{b^{n - 1}}{a^{n - 1}} \right) = a^n - b^n,\\

\left( a - b \right)  \left( a^{n - 1} + a^{n - 1}\frac{b}{a} + a^{n - 1}\frac{b^2}{a^2} + a^{n - 1}\frac{b^3}{a^3} + \dots + a^{n - 1}\frac{b^{n - 1}}{a^{n - 1}} \right) = a^n - b^n,\\

\left( a - b \right)  \left( a^{n - 1} + a^{n - 2}b + a^{n - 3}b^2 + a^{n - 4}b^3 + \dots + b^{n - 1} \right) = a^n - b^n.\\
\end{aligned}$$

This problem reminds me of one talk by Simon Sinek regarding how people cannot ignore the negative ([see here](https://www.youtube.com/watch?v=W05FYkqv7hM)). Let me elaborate. He started to talk by showing that people cannot avoid thinking of an elephant when told: "*do not think of an elephant*." Later on, he expanded on this idea by discussing how skiers should not focus on "*not hitting the trees*" but they should focus on "staying on the path." In essence, I have encountered something similar with this problem as well. Just focusing on where I want to get in the end seems to be sufficient to guide me through the whole derivation of this formula. I do hope I will be able to recreate this in several months without brushing up!