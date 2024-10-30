# Chapter 1 - Hello world with nextflow

A "Hello, World!" is a minimalist example that is meant to demonstrate the basic syntax and structure of a programming language or software framework. The example typically consists of printing the phrase "Hello, World!" to the output device, such as the console or terminal, or writing it to a file.

In this first part of the Hello Nextflow training course, we ease into the topic with a very simple domain-agnostic Hello World example, which we'll progressively build up to demonstrate the usage of foundational Nextflow logic and components.

## 0. Warmup: run Hello world on terminal

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

## 1. Run Hello world with nextflow script.

As mentioned in the orientation, we provide you with a fully functional if minimalist workflow script named hello-world.nf that does the same thing as before (write out 'Hello World!') but with Nextflow.

To get you started, we'll first open up the workflow script so you can get a sense of how it's structured, then we'll run it (before trying to make any modifications) to verify that it does what we expect.

```nextflow
#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to standard out
 */
process sayHello {

    output:
        stdout

    """
    echo 'Hello World!'
    """
}

workflow {

    // emit a greeting
    sayHello()
}
```
