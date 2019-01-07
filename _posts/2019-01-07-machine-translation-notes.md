---
layout: post
title: Machine Translation Notes
subtitle: How to translate automatically?
comments: true
bigimg: /img/notes.jpg
tags: [note]
---

Recently, I have learnt something about machine translation and done a presentation about it. Why not transform the slides into my first post? This post contains some personal understandings of some popular models like, Google's Neural Machine Translation System [[Wu et al.]](https://arxiv.org/abs/1609.08144), Attention is all you need [[Vaswani et al.]](https://arxiv.org/abs/1706.03762) and so on, and if there is any misunderstandings, please correct me in the comment.

## What is machine translation?
Machine translation is a very straight forward term, that is to let the program do translation work automatically, translating a sentence from one language to another. The following is an example translating a sentence in English to Chinese.
![Translation Example](../assets/machine_translation/example.png)
More formally speaking, the goal of the machine translation task is actually **maximize the probability of the target sentence $Y$ given the source sentence $X$**, that is maximizing $P(Y|X)$. 
### Objective function
Before we talk about the objective function of the task, we can take a closer look at the goal. By applying Bayes' theorem to the probability $P(Y|X)$, we can have that 
$$\text{maximize } P(Y|X) = \prod_{i=0}^n P(Y_i | X, Y_0, \cdots, Y_{i-1}).$$ 
And the actual meaning of each term is that the probability of the $i^{th}$ phrase in target sentence given the source sentence $X$ and the prefix of this phrase. In the figure below, $P(Y_2 | X, Y_0, Y_1)$, for example, is the probability of "借" given "Can I borrow your book?", "我" and "能".
![Probability Example](../assets/machine_translation/p_example.png){:height="30%" width="30%" .center-image}

As a common trick, we can take logarithm of the production and get the objective function of the task, that is 
$$\text{maximize} \sum_{i=0}^n \log P(Y_i | X, Y_0, \cdots, Y_{i-1}).$$
This objective function is equivalent to the original goal, but we can benefit a lot from it when designing a algorithm to achieve the goal.

Instead of designing a translator that generate the whole target sentence all at once (this may be quite hard as the length of the target sentence varies for different inputs), with the summation of log probabilities in mind, the translator can predict the probability for one phrase at a time given the source sentence and the prefix of this phrase. By running the translator several times, each time have one more phrase in the prefix, the translator can generate the target sentence.
![Translator Objective](../assets/machine_translation/translator_obj.png){:.center-image}


**TO BE CONTINUE!**

