## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 8. Hello nf-core

nf-core is a community effort to develop and maintain a curated set of analysis pipelines built using Nextflow.

<img src="/readme_figures/nf-core-logo.png">

nf-core provides a standardized set of best practices, guidelines, and templates for building and sharing scientific pipelines. These pipelines are designed to be modular, scalable, and portable, allowing researchers to easily adapt and execute them using their own data and compute resources.

One of the key benefits of nf-core is that it promotes open development, testing, and peer review, ensuring that the pipelines are robust, well-documented, and validated against real-world datasets. This helps to increase the reliability and reproducibility of scientific analyses and ultimately enables researchers to accelerate their scientific discoveries.

nf-core is published in Nature Biotechnology: 
[https://www.nature.com/articles/s41587-020-0439-x](https://www.nature.com/articles/s41587-020-0439-x). 
An updated preprint is available at 
[https://www.biorxiv.org/content/10.1101/2024.05.10.592912v1](bhttps://www.biorxiv.org/content/10.1101/2024.05.10.592912v1).

### nf-core pipelines and other components

The nf-core collection currently offers over 100 pipelines
[https://nf-co.re/pipelines](https://nf-co.re/pipelines) in various stages of development, 
72 subworkflow [https://nf-co.re/subworkflows](https://nf-co.re/subworkflows) and 
over 1300 module [https://nf-co.re/modules](https://nf-co.re/modules) that you can use to build your own pipelines.


Each released pipeline has a dedicated page that includes 6 documentation sections:

- **Introduction**: An introduction and overview of the pipeline
- **Usage**: Descriptions of how to execute the pipeline
- **Parameters**: Grouped pipeline parameters with descriptions
- **Output**: Descriptions and examples of the expected output files
- **Results**: Example output files generated from the full test dataset
- **Releases & Statistics**: Pipeline version history and statistics

You should read the pipeline documentation carefully to understand what a given pipeline does and how it can be configured before attempting to run it.

### Pulling an nf-core pipeline

One really cool aspect of how Nextflow manages pipelines is that you can pull a pipeline from a GitHub repository without cloning the repository. This is really convenient if you just want to run a pipeline without modifying the code.

So if you want to try out an nf-core pipeline with minimal effort, you can start by pulling it using the `nextflow pull` command.