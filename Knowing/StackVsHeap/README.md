# Stack Vs Heap

Besides being an excellent interview question, knowing the difference between a stack and a heap will make you a better programmer.

Let's now look at:

- what stacks and heaps are
- why they are important, and then see
- how they affect us when we are programming

## What is a Stack

- Stack is an efficient way to storing elements of your program in memory.
- Access to stack is very quick.
- Instance of variables are copied.
- And when you pop something from the stack you get a `copy` of what was there - not a `pointer` or `reference` to the real thing
- Stacks are where `structs` are stored in Swift.
- And it's the ability to rapidly access elements on stacks which makes `structs` the preferred construct to building programs in Swift.
- That's what Apple recommends `structs` over `classes` when building programs.

## What is a Heap

- Heap is another way means of storing program elements in memory.
- Heaps are where references and entire hierarchies or pointers are stored and all their relationships to one anothers
- `classes` are stored on heaps.
- So when you have a complex view hierarchy in `UIKit` and you store references to view controllers in memory, all this takes place in the heap
- The heap is able to store all these complex relationships and access them with ease
- The heap is slower than the stack
- But necessary when working with classes
- Which is why heap still plays a big part of iOS development today

## Why should I care?

This matters to you as an iOS developer because not knowing how stacks and heaps work can frustrate you when first getting into Swift, and starting to build non-trivial programs.

## Classes passes by reference - Heap

For example, here is a real life example of an algorithm I needed to write that matched students with courses. It's class based. Which means when I pass `students` and `courses` into the `match` alorithm, I am passing references to those objects. Any changes to make in the algorithm get reflected in the calling program.

All these work takes place on the heap.

## Structs pass by copy - Stack

But what if I am new to Swift, I read the `structs` should be favored over classes, and I go to write that same algorithm using `structs` only it doesn't work!

### Stacks and Classes are not passed the same way

This is why it's important to understand what's going on under the hood and why stacks and heaps are different.

If you are coming from another language where objects are typically passed by reference, you are going to naturally assume everything behaves like a class.

But when you come into Swift, things are different. Not only do you have classes, you have these other very similar looks light-weight structures called structs, only they behave different.

And not knowing the difference can lead to frustration and bugs in your program.

## Why favor struct?

Now I know what you're thinking. If classes are easier and how most things work, why use structs at all?

Structs are favored for speed, and no state.

### Speed

- Memory access to a stack is faster than that of the heap.
- So one beg reasons structs are favored over classes is their ability to be popped off the stack quickly, and accessed quickly in the name of speed.


### Stateless

Swift straddles two worlds when it comes to programming paradigms:

- Object-Oriented (OO), and
- Functional

Object-Oriented (OO) has been around for a long time, and is a tried and true method for building programs.

But things about programs into terms of functions instead of objects has its advantages too. When you don't track and pass around state like one does with OO, you get simpler programs with fewer side-effects.

Instead of alterating the state of an element in one part of your program, and then having it have an unintended side-effect and inadvertinly affecting another, with functional programming there is no state. There are only inputs and outputs. Fewer side-effects. Fewer bugs.

## SwiftUI vs UIKit

And this brings us to perhaps the biggest manifestation of them all: SwiftUI (stack based) vs UIKit (heap based).

SwiftUI heavily leverages structs and stacks. There are no references to views in SwiftUI. Every view is a cheap struct. Whenever the state of the app changes, you simply create a new view and through away the old one. That's SwiftUI.

This is very different than UIKit where everything is a class. With classes, we are passing things around on the heap. So if you change the state of a control in UIKit, that control gets changed everywhere.

That can be a good or a bad thing. We have gotten very good and build UIKit applications over the years. But there are unintended side effects and complications building apps this way. Which is why the future, and SwiftUI rely way more heavilty on structs. The hope is that this will lead to simpler programs with way less side-effects and bugs.

## In Summary

Knowing the different between stacks and heaps will help you make sense of the Swift programming world. Now that you know:

- classes are for heaps
- structs are for stacks

And the advantages that both bring, you will be able to walk comfortably in both worlds. One isn't necessary better than the other. Evern SwiftUI still uses classes because it does have to store app state somewhere.

But knowing the differences and where and when to use each will not only enable you to answer this question in an interview, it will make you a better programmer.

🕹🚀🎉🌈
