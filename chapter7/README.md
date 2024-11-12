## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 7. Hello `nf-test`

Being able to systematically test that every part of your workflow is doing what it's supposed to do is critical for reproducibility and long-term maintenance. And it's also helpful during the development process!

This is (hopefully) not controversial. However, people often focus on setting up top-level tests, in which the workflow is run on some test data from start to finish. This is useful, but unfortunately incomplete. You should also implement tests at the level of each individual module (equivalent to what is called 'unit tests' in general software engineering) to verify the functionality of individual components of your workflow. That will ensure that each module performs as expected under different conditions and inputs. And it also means that when you assemble a new workflow from existing modules that already have tests, you get built-in testing for free!

In this part of the training, we're going to show you how to use **nf-test**, a testing framework that integrates well with Nextflow and makes it straightforward to add both module-level and workflow-level tests to your pipeline. For more background information about nf-test, we recommend you read this blog post.

### 0. Warmup

### 1. Test a process for success and matching outputs