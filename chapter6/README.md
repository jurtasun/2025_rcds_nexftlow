## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 6. Hello modules

This section covers how to organize your workflow code to make development and maintenance of your pipeline more efficient and sustainable. Specifically, we are going to demonstrate how to use **modules**.

In Nextflow, a module is a single process definition that is encapsulated by itself in a standalone code file. To use a module in a workflow, you just add a single-line import statement to your workflow code file; then you can integrate the process into the workflow the same way you normally would.

Putting processes into individual **modules** makes it possible to reuse process definitions in multiple workflows without producing multiple copies of the code. This makes the code more shareable, flexible and maintainable.

### 0. Warmup

### 1. Create a module for the `SAMTOOLS_INDEX` process