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

{: .center-image}
![Translation Example](../assets/machine_translation/example.png)



More formally speaking, the goal of the machine translation task is actually **maximize the probability of the target sentence $Y$ given the source sentence $X$**, that is maximizing $P(Y|X)$. 
### Objective function
Before we talk about the objective function of the task, we can take a closer look at the goal. By applying Bayes' theorem to the probability $P(Y|X)$, we can have that 
$\text{maximize } P(Y|X) $ $= \prod_{i=0}^n P(Y_i | X, Y_0, \cdots, Y_{i-1}).$ 
And the actual meaning of each term is that the probability of the $i^{th}$ phrase in target sentence given the source sentence $X$ and the prefix of this phrase. In the figure below, $P(Y_2 | X, Y_0, Y_1)$, for example, is the probability of "借" given "Can I borrow your book?", "我" and "能".

{: .center-image}
![Probability Example](../assets/machine_translation/p_example.png "Probability Example"){:height="30%" width="30%"}

As a common trick, we can take logarithm of the production and get the objective function of the task, that is 
$$\text{maximize} \sum_{i=0}^n \log P(Y_i | X, Y_0, \cdots, Y_{i-1}).$$
This objective function is equivalent to the original goal, but we can benefit a lot from it when designing a algorithm to achieve the goal.

Instead of designing a translator that generate the whole target sentence all at once (this may be quite hard as the length of the target sentence varies for different inputs), with the summation of log probabilities in mind, the translator can **predict the probability for one phrase at a time** given the source sentence and the prefix of this phrase. By running the translator several times, each time have one more phrase in the prefix, the translator can generate the target sentence.

{:.center-image}
![Translator Objective](../assets/machine_translation/translator_obj.png "Translator Objective")

## Time for methods!
There are several methods that are designed to achieve the goal we mentioned before, including *statistical*, *sequence to sequence*, *transformer*, etc.
### Statistical - Phrase-Based Translation
The statistical method is the conventional way to do the translation task. And the one used in [[1]](#Reference) is called phrase-based translation.

The main idea of this method is that when the program takes a foreign input, it will firstly cut the input into phrases and then **translate these phrases one by one independently**. Finally, the program will **reorder the translated phrases** to make the target sentence more natural.
![Phrase-Based Example](../assets/machine_translation/phrase_based.png)
And the goal of this method is to $\text{maximize } P(Y|X)$ by maximizing $P(X|Y)\cdot P_{LM}(Y)$, where $P_{LM}$ is a language model that measures the order of the predicted sentence, by evaluating each trigram in the sentence. There are some elegant and mathematical way to design the translation model and the language model, but I am not going to discuss them here.

### Sequence to Sequence - GNMT
For a more advance model for machine translation, Google published a model called Google's Neural Machine Translation System [[2]](#Reference), or for short GNMT. And the architecture is shown the figure below.
![GNMT](../assets/machine_translation/GNMT_model.png)

{:.image-caption}
Figure Credit: [Wu et al.], Google's Neural Machine Translation System [[2]](#Reference)

The GNMT uses a lot of Long Short Term Memory networks (LSTMs) stacked together, all of the layers are one-directional LSTM except the one at the input, which is a bidirectional LSTM. The model can be divided into three parts, including an encoder, a decoder and an attention part in the middle. The figure below is a simplified GNMT model.

![Simplified GNMT](../assets/machine_translation/gnmt_simple.png)

In this example, for the model, a source sentence, "Can I borrow your book?", is given, the encoder will take the sequence of word embedding representing the source sentence. By the way, word embedding is a kind of vectors in a quite low dimension  space (much smaller than the vocabulary space) that can represent words. When the encoder gets the embedding sequence, it outputs a sequence of hidden vectors with the same length as the input sentence. In expectation, these hidden vectors should contains the information of the phrases in the source sentence as well as the information of the whole sequence.

To make it clear, the training and testing process of GNMT is to optimize the objective function we mentioned before -- $\text{maximize } \sum_{i=0}^n P(Y_i|X, Y_0, \cdots, Y_{i-1})$. GNMT predicts a phrase in the target sentence one by one. And each time, the decoder will be fed with the prefix of the phrase we want to predict. 
![Decoder of GNMT](../assets/machine_translation/gnmt_decoder.png)
Getting the hidden vectors, the attention part use the information of the prefix, and generate a sequence of weights for the hidden sequence. Taking the weighted average of the hidden vectors, the attention part outputs a embedding vector that contains the all the information from the source sentence. In the meantime, the information in the embedding vector is focused on predicting the next phrase after the prefix because of the weight applied to the hidden vectors.

Finally, the LSTMs in the decoder uses the word embedding sequence of the prefix and the embedding vector $e_3$ and outputs the probability for the next phrase. The model then can calculate the objective function by adding up these log probabilities. 

The training process takes the gradient of the objective function and updates the parameters in the model. The testing process, however, the model will use beam search for generating target sentence. 

## Transformer - Attention is All You Need

**TO BE CONTINUE!**


## Reference
[1] [Statistical Phrase-Based Translation](http://www.aclweb.org/anthology/N03-1017), Philipp Koehn, Franz Josef Och, Daniel Marcu. Presentations at DARPA IAO Machine Translation Workshop, 2002

[2] [Google’s Neural Machine Translation System: Bridging the Gap between Human and Machine Translation](https://arxiv.org/abs/1609.08144), Yonghui Wu, Mike Schuster, Zhifeng Chen, Quoc V. Le, Mohammad Norouzi, Wolfgang Macherey, Maxim Krikun, Yuan Cao, Qin Gao, Klaus Macherey, Jeff Klingner, Apurva Shah, Melvin Johnson, Xiaobing Liu, Łukasz Kaiser, Stephan Gouws, Yoshikiyo Kato, Taku Kudo, Hideto Kazawa, Keith Stevens, George Kurian, Nishant Patil, Wei Wang, Cliff Young, Jason Smith, Jason Riesa, Alex Rudnick, Oriol Vinyals, Greg Corrado, Macduff Hughes, Jeffrey Dean. Technical Report, 2016.

[3] [Attention is All You Need](https://arxiv.org/abs/1706.03762), Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, Illia Polosukhin, NeurIPs 2017.


