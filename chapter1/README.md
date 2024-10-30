# Chapter 1 - Hello world with nextflow

## Jesús Urtasun Elizari
## LMS Bioinformatics

<img src="/readme_figures/nextflow-logo.png">
<img src="/readme_figures/nf-core-logo.png">

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

You now know how to run a simple command in the terminal that outputs some text, and optionally, how to make it write the output to a file. Next, we will discover what that would look like written as a Nextflow workflow.

## 1. Run Hello world with nextflow script

### 1.1 The code structure

As mentioned in the orientation, we provide you with a fully functional if minimalist workflow script named `hello-world.nf` that does the same thing as before (write out 'Hello World!') but with Nextflow.

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

The first block of code describes a process. The process definition starts with the keyword `process`, followed by the process name and finally the process body delimited by curly braces. The process body must contain a script block which specifies the command to run, which can be anything you would be able to run in a command line terminal. Here we have a process called `sayHello` that writes its output to `stdout`.

The second block of code describes the workflow itself. The workflow definition starts with the keyword `workflow`, followed by an optional name, then the workflow body delimited by curly braces.. Here we have a workflow that consists of one call to the `sayHello` process.

### 1.2. Run the workflow

Run the following command in your terminal

```bash
nextflow run hello-world.nf
```
The most important output here is the last line (line 6), which reports that the `sayHello` process was successfully executed once.

Okay, that's great, but where do we find the output? The `sayHello` process definition said that the output would be sent to standard out, but nothing got printed in the console, did it?

# 2. Send the output to a file

# 3. Use the Nextflow resume feature

# 4. Add in variable inputs using a channel

# 5. Use CLI parameters for inputs

# 7. Add a second step to the workflow

# 8. Run workdlow with many input values

# 9. Run workflow with an input runcard / sample sheet.