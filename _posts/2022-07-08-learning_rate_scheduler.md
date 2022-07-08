---
layout: post
use_mathjax: true
title: Exponential Learning Rate Scheduler
date: 2022-07-08 08:00:00 +0100
categories: [research]
excerpt: A short post regarding exponential learning rate scheduler.
---

# Motivation

When training **deep neural networks**, **learning rate** is arguably a hyperparameter of paramount importance. However, in many scenarios, altering the learning rate during the model training may help not only help stabilize the training but also help find better local minima. There are various ways to approach so-called **scheduling** the **learning rate** during the training. Deep learning frameworks such as [PyTorch](https://pytorch.org/) or [TensorFlow](https://www.tensorflow.org/) provide basic infrastructure that supports this functionality. One of the approaches is based on using [exponential decay](https://en.wikipedia.org/wiki/Exponential_decay).

This short post aims to provide a simple guide regarding how to derive the necessary parameters for a learning rate scheduler using exponential decay given that we know our **base learning rate**, **target learning rate** we want to reach, the **total number of epochs** as well as the **number of warm-up epochs** (in which the learning rate remains untouched).

*Note: To be honest, I had to use re-derive this formula multiple times. Thus, I decided to save the processes as part of a blog post for future reference at least for me, if not for anyone else.*

In this post, we will use the **TensorFlow** deep learning framework. Nevertheless, the reasoning and methodology are very general and can be applied to any scenario involving finding the parameters of a function for exponential decay.

More specifically, we will strive to implement the scheduling **function** for the [LearningRateScheduler](https://www.tensorflow.org/api_docs/python/tf/keras/callbacks/LearningRateScheduler) class representing a [callback](https://en.wikipedia.org/wiki/Callback_(computer_programming)) function. Its instance can be constructed as

```python
tf.keras.callbacks.LearningRateScheduler(
    schedule, verbose=0
)
```

The arguments are

| argument | description |
| -------- | ----------- |
| `schedule` | a function that takes an epoch index (integer (`int`), indexed from $0$) and current learning rate (`float`) as inputs and returns a new learning rate as output (`float`). |
| `verbose`  | `int`. $0$ - quiet, $1$ - update messages. |

At the beginning of every epoch, this callback gets the updated learning rate value from the `schedule` function. Please, refer to the dedicated [documentation](https://www.tensorflow.org/api_docs/python/tf/keras/callbacks/LearningRateScheduler) section for further details.

# Formula Derivation

Let $B$ be the **base learning rate**, $T$ be the **target learning rate**, $N$ be the **total number of epochs** and $W$ be the **number of warm-up epochs**. The aim is to find a parameter $\lambda$, i.e., the **decay rate**, so that our learning rate scheduler equals $B$ for all the warm-up epochs including the first "real" epochs and after the $N - \left (W + 1 \right)$ epochs it reaches the value of $T$.

Generally speaking, we want to find a function that takes two parameters, the current **epoch index** $i$ (indexed from $0$) and the current **learning rate** $r$ and returns a **new learning rate** $\tilde{r}$. So,

$$f \left( i, r \right) = \tilde{r}.$$

Considering the aforementioned requirements, the **decay rate** $\lambda$ is equal to

$$\lambda = \frac{\log \left( \frac{T}{B} \right)}{E - \left(W + 1 \right)}.$$

Thus, the sought **function** $f \left( \cdot \right)$ can be defined as

$$
f \left( i, r \right) =
\begin{cases}
    B \qquad & \text{if } i \leq W,\\
    B \cdot e^{\lambda} \qquad & \text{otherwise}.
\end{cases}
$$

# Implementation

The only required import is:
```python
import tensorflow as tf
```

The derived formula can be transformed into a Python implementation as follows

```python
def make_lr_scheduler(base_lr, target_lr, n_epochs, n_warmup_epochs):
    n_update_epochs = n_epochs - n_warmup_epochs - 1
    decay_rate = tf.math.log(target_lr / base_lr) / n_update_epochs

    def _scheduler(epoch, lr):
        if epoch <= n_warmup_epochs:
            return base_lr
        else:
            return lr * tf.math.exp(decay_rate)

    return _scheduler
```

The above function creates another function which is then passed to the `model.fit(...)` method as a callback. Concretely, let `model` be a TensorFlow [model](https://www.tensorflow.org/api_docs/python/tf/keras/Model) instance. When calling its `fit()` method, one of the parameters is `callbacks`, a list of callback functions to be called during the training. 

Assume we have the following variables in our **configuration**

```python
BASE_LR = ...
TARGET_LR = ...
N_EPOCHS = ...
N_WARMUP_EPOCHS = ...
```

Then, the **learning rate scheduler** can be **instantiated** and utilized during the training as

```python
lr_scheduler_callback = make_lr_scheduler(
    base_lr=BASE_LR,
    target_lr=TARGET_LR,
    n_epochs=N_EPOCHS,
    n_warmup_epochs=N_WARMUP_EPOCHS
)

model.fit(train_dataset, epochs=N_EPOCHS, callbacks=[lr_scheduler_callback])
```

# Implementation Verification

Here is a table that shows how the learning rate **progresses** with respect to different parameters.

| $B$       | $T$       | $N$ | $W$ | $i = 0$    | $i = 1$    | $i = 2$    | $i = 3$    | $i = 4$    |
| --------- | --------- | --- | --- | ---------- | ---------- | ---------- | ---------- | ---------- |
| $10^{-1}$ | $10^{-6}$ | $5$ | $0$ | $0.100000$ | $0.005623$ | $0.000316$ | $0.000018$ | $0.000001$ |
| $10^{-2}$ | $10^{-4}$ | $5$ | $1$ | $0.010000$ | $0.010000$ | $0.002154$ | $0.000464$ | $0.000100$ |
| $10^{-2}$ | $10^{-5}$ | $5$ | $2$ | $0.010000$ | $0.010000$ | $0.010000$ | $0.000316$ | $0.000010$ |

# Conclusion

In this post, we covered how to **derive** the **decay rate** parameter for **exponential decay function**. As for the real-world use case, we showed a direct application to **learning rate scheduling** within the **TensorFlow** deep learning framework.