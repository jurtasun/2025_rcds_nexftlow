## RCDS 2025 - Introduction to Nextflow & nf-core

### Dr. Jesús Urtasun Elizari, ICL Research Computing & Data Science

ICL email address `jurtasun@ic.ac.uk`

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 3. Channels and workflow

In Part 1, you learned how to use the basic building blocks of Nextflow to assemble a simple pipeline capable of processing some text and parallelizing execution if there were multiple inputs. Then in Part 2, you learned how to use containers to pull in command line tools to test them and integrate them into your pipelines without having to deal with software dependency issues.

In most realistic workflow use cases, we want to process multiple values (experimental data for multiple samples, for example), so we need a more sophisticated way to handle inputs. That is what Nextflow channels are for. Channels are queues designed to handle inputs efficiently and shuttle them from one step to another in multi-step workflows, while providing built-in parallelism and many additional benefits.

In this part of the course, you will learn how to use a channel to handle multiple inputs from a variety of different sources. You will also learn to use operators to transform channel contents as needed.
s