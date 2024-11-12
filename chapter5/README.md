## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 5. Config nextflow

This section will explore how to set up and manage the configuration of your Nextflow pipeline so that you'll be able to customize its behavior, adapt it to different environments, and optimize resource usage *without altering a single line of the workflow code itself*.

We're going to cover essential components of Nextflow configuration such as config files, profiles, process directives, executors, and parameter files. By learning to utilize these configuration options effectively, you can enhance the flexibility, scalability, and performance of your pipelines.

### 0. Warmup: Moving to a formal project structure

So far we've been working with a very loose structure, with just one workflow code file and a tiny configuration file that we've mostly ignored, because we were very focused on learning how to implement the workflow itself. However, we're now moving into the phase of this training series that is more focused on code development and maintenance practices.

As part of that, we're going to adopt a formal project structure. We're going to work inside a dedicated project directory called `hello-config`, and we've renamed the workflow file `main.nf` to match the recommended Nextflow convention.

### 1. Determine what software packaging technology to use

### 2. Use profiles to select preset configurations

### 3. Determine what executor(s) should be used to do the work

### 4. Allocate compute resources with process directives

### 5. Configure workflow parameters