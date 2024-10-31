# LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

## Chapter 1 - Hello world with nextflow

A "Hello, World!" is a minimalist example that is meant to demonstrate the basic syntax and structure of a programming language or software framework.
The example typically consists of printing the phrase "Hello, World!" to the output device, such as the console or terminal, or writing it to a file.

In this first part of the Hello Nextflow training course, we ease into the topic with a very simple domain-agnostic Hello World example, 
which we'll progressively build up to demonstrate the usage of foundational Nextflow logic and components.

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

You now know how to run a simple command in the terminal that outputs some text, and optionally, how to make it write the output to a file. 
Next, we will discover what that would look like written as a Nextflow workflow.

## 1. Run Hello world with nextflow script

### 1.1 The code structure

As mentioned in the orientation, we provide you with a fully functional if minimalist workflow script named `hello-world.nf` 
that does the same thing as before (write out 'Hello World!') but with Nextflow.

To get you started, we'll first open up the workflow script so you can get a sense of how it's structured, 
then we'll run it (before trying to make any modifications) to verify that it does what we expect.

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

The first block of code describes a process. The process definition starts with the keyword `process`, 
followed by the process name and finally the process body delimited by curly braces. 
The process body must contain a script block which specifies the command to run, 
which can be anything you would be able to run in a command line terminal. 
Here we have a process called `sayHello` that writes its output to `stdout`.

The second block of code describes the workflow itself. The workflow definition starts with the keyword `workflow`, 
followed by an optional name, then the workflow body delimited by curly braces. 
Here we have a workflow that consists of one call to the `sayHello` process.

### 1.2. Run the workflow

Run the following command in your terminal.

```bash
nextflow run hello-world.nf
```
The most important output here is the last line (line 6), which reports that the `sayHello` process was successfully executed once.

Okay, that's great, but where do we find the output? The `sayHello` process definition said that the output would be sent to standard out, 
but nothing got printed in the console, did it?

## 2. Send the output to a file

Instead of printing "Hello World!" to standard output, we'd prefer to save that output to a specific file, 
just like we did when running in the terminal earlier.
This is how most tools that you'll run as part of real-world pipelines typically behave; we'll see examples of that later.

To achieve this result, both the script and the output definition blocks need to be updated.

### 2.1. Update the process command to output a named file

This is the same change we made when we ran the command directly in the terminal earlier.

*before*
```nextflow
    """
    echo 'Hello World!'
    """
```
*after*
```nextflow
    """
    echo 'Hello World!' > output.txt
    """
```

### 2.2. Update the output declaration in the `sayHello` process

We need to tell Nextflow that it should now look for a specific file to be produced by the process execution.

*before*
```nextflow
    output:
        stdout
```
*after*
```nextflow
    output:
        path 'output.txt'
```

Run the updated file in your terminal.

```bash
nextflow run hello-world.nf
```

Like you did before, find the `work` directory in the file explorer. 
There, find the `output.txt` output file and verify that it contains the greeting as expected.

### 2.3. Add a `publishDir` directive to the process

You'll have noticed that the output is buried in a working directory several layers deep. 
Nextflow is in control of this directory and we are not supposed to interact with it. 
To make the output file more accessible, we can utilize the `publishDir` directive. 
By specifying this directive, we are telling Nextflow to automatically copy the output file to a designated output directory. 
This allows us to leave the working directory alone, while still having easy access to the desired output file.

*before*
```nextflow
process sayHello {

    output:
        stdout
```
*after*
```nextflow
process sayHello {

    publishDir 'results', mode: 'copy'

    output:
        stdout
```

Run the updated file in your terminal.

```bash
nextflow run hello-world.nf
```

This time, Nextflow will have created a new directory called `results/`. In this directory is our `output.txt` file. 
If you check the contents it should match the output in our work/task directory. This is how we move results files outside of the working directories.
This way, you can send outputs to a specific named file and use the `publishDir` directive to move files outside of the Nextflow working directory.

## 3. Use the Nextflow resume feature

Nextflow has an option called -resume that allows you to re-run a pipeline you've already launched previously. 
When launched with -resume any processes that have already been run with the exact same code, settings and inputs will be skipped. 
Using this mode means Nextflow will only run processes that are either new, have been modified or are being provided new settings or inputs.

There are two key advantages to doing this:

- If you're in the middle of developing your pipeline, you can iterate more rapidly since you only effectively have to run the process(es) you're actively working on in order to test your changes.
- If you're running a pipeline in production and something goes wrong, in many cases you can fix the issue and relaunch the pipeline, 
and it will resume running from the point of failure, which can save you a lot of time and compute.

## 4. Add in variable inputs using a channel

Run the updated file in your terminal.

```bash
nextflow run hello-world.nf
```

Notice the additional `cached:` bit in the process status line, which means that Nextflow has recognized that it has already done this work and simply re-used the result from the last run.

## 5. Add in variable inputs using a channel

So far, we've been emitting a greeting hardcoded into the process command. 
Now we're going to add some flexibility by using an input variable, so that we can easily change the greeting.

This requires us to make a series of inter-related changes:

1. Tell the process about expected variable inputs using the `input:` block
2. Edit the process to use the input
3. Create a **channel** to pass input to the process (more on that in a minute)
4. Add the channel as input to the process call

### 5.1. Add an input definition to the process block

First we need to adapt the process definition to accept an input.

*before*
```nextflow
process sayHello {

    output:
        stdout
```
*after*
```nextflow
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting

    output:
        stdout
```

### 5.2. Edit the process command to use the input variable

Now we swap the original hardcoded value for the input variable.

*before*
```nextflow
    """
    echo 'Hello World!' > output.txt
    """
```
*after*
```nextflow
    """
    echo '$greeting' > output.txt
    """
```

### 5.3. Create an input channel

Now that our process expects an input, we need to set up that input in the workflow body. This is where channels come in: 
Nextflow uses channels to feed inputs to processes and ferry data between processes that are connected together.

There are multiple ways to do this, but for now, we're just going to use the simplest possible channel, containing a single value.

We're going to create the channel using the `Channel.of()` factory, which sets up a simple value channel, 
and give it a hardcoded string to use as greeting by declaring `greeting_ch = Channel.of('Hello world!')`.

*before*
```nextflow
workflow {

    // emit a greeting
    sayHello()

}
```
*after*
```nextflow
workflow {

    // create a channel for inputs
    greeting_ch = Channel.of('Hello world!')

    // emit a greeting
    sayHello()

}
```

### 5.4. Add the channel as input to the process call

Now we need to actually plug our newly created channel into the `sayHello()` process call.

*before*
```nextflow

// emit a greeting
sayHello()

```
*after*
```nextflow

// emit a greeting
sayHello(greeting_ch)

```

Run the updated file in your terminal.

```bash
nextflow run hello-world.nf
```

Feel free to check the results directory to satisfy yourself that the outcome is still the same as previously; 
so far we're just progressively tweaking the internal plumbing to increase the flexibility of our workflow while achieving the same end result.
You know how to use a simple channel to provide an input to a process.

## 6. Use CLI parameters for inputs

We want to be able to specify the input from the command line, since that is the piece that will almost always be different in subsequent runs of the workflow. Good news: Nextflow has a built-in workflow parameter system called `params`, which makes it easy to declare and use CLI parameters.

### 6.1. Edit the input channel declaration to use a parameter

Here we swap out the hardcoded string for `params.greeting` in the channel creation line.

*before*
```nextflow

// create a channel for inputs
greeting_ch = Channel.of('Hello world!')

```
*after*
```nextflow

// create a channel for inputs
greeting_ch = Channel.of(params.greeting)

```

This automatically creates a parameter called `greeting` that you can use to provide a value in the command line.

### 6.2. Run the workflow again with the `--greeting parameter`

To provide a value for this parameter, simply add `--greeting <value>` to your command line.

```bash
nextflow run hello-world.nf --greeting 'Bonjour le monde!'
```

### 6.3. Set a default value for a command line paramete

In many cases, it makes sense to supply a default value for a given parameter so that you don't have to specify it for every run.

Let's initialize the greeting parameter with a default value by adding the parameter declaration at the top of the script.

```nextflow

// Pipeline parameters
params.greeting = "Holà mundo!"

```

Now that you have a default value set, you can run the workflow again without having to specify a value in the command line.

```bash
nextflow run hello-world.nf
```

Check the output in the results directory, and... Tadaa! It works! Nextflow used the default value to name the output. 
But wait, what happens now if we provide the parameter in the command line?

Run the workflow again with the `--greeting` parameter on the command line using a different greeting

```bash
nextflow run hello-world.nf --greeting 'Konnichiwa!
```

Check the results directory and look at the contents of `output.txt`. Tadaa again!

The value of the parameter we passed on the command line overrode the value we gave the variable in the script.
Now you know how to set up an input variable for a process and supply a value in the command line.
Learn how to add in a second process and chain them together.

## 7. Add a second step to the workflow

## 8. Run workdlow with many input values

## 9. Run workflow with an input runcard / sample sheet.