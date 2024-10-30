# Chapter 1 - Hello world with nextflow

A "Hello, World!" is a minimalist example that is meant to demonstrate the basic syntax and structure of a programming language or software framework. The example typically consists of printing the phrase "Hello, World!" to the output device, such as the console or terminal, or writing it to a file.

In this first part of the Hello Nextflow training course, we ease into the topic with a very simple domain-agnostic Hello World example, which we'll progressively build up to demonstrate the usage of foundational Nextflow logic and components.

## Warmup: run Hello world on terminal

Let's demonstrate this with a simple command that we run directly in the terminal, to show what it does before we wrap it in Nextflow.
```bash
echo 'Hello World!'
```
Now make it write the text output to a file.
```bash
echo 'Hello World!' > output.txt
```
Verify that the output file is there using the ls command.
```bash
ls
```
Show the file contents
```bash
less output.txt
```