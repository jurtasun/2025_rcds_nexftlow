## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 3. Genomics with nexftlow.

In Part 1, you learned how to use the basic building blocks of Nextflow to assemble a simple pipeline capable of processing some text and parallelizing execution if there were multiple inputs. Then in Part 2, you learned how to use containers to pull in command line tools to test them and integrate them into your pipelines without having to deal with software dependency issues.

Now, we show you how to use the same components and principles to build a pipeline that does something a bit more interesting, and hopefully a bit more relatable to your work. Specifically, we show you how to implement a simple variant calling pipeline with **GATK** (Genome Analysis Toolkit), a widely used software package for analyzing high-throughput sequencing data.

#### Method overview.

Variant calling is a genomic analysis method that aims to identify variations in a genome sequence relative to a reference genome. Here we are going to use tools and methods designed for calling short variants, *i.e.* SNPs and indels.

<img src="/readme_figures/genomics1.png">

A full variant calling pipeline typically involves a lot of steps, including mapping to the reference and variant filtering and prioritization. For simplicity, we are going to focus on the core variant calling step, which takes as its main input a file of short-read sequencing data in BAM format (Binary Alignment Map, a compressed version of SAM, Sequence Alignment Map), as well as a reference genome and a list of genomic intervals to analyze.

For this exercise, we provide you with three samples in BAM format (see Dataset below). However, **GATK** requires an index file for each BAM file, which we did not provide (on purpose), so the workflow will have to create one as a preliminary step.

So to recap, we're going to develop a workflow that does the following:

- Generate an index file for each BAM input file using Samtools
- Run the **GATK** HaplotypeCaller on each BAM input file to generate per-sample variant calls in VCF (Variant Call Format)

<img src="/readme_figures/genomics2.png">

#### Dataset

- A reference genome consisting of a small region of the human chromosome 20 (from hg19/b37) and its accessory files (index and sequence dictionary).
- Three whole genome sequencing samples corresponding to a family trio (mother, father and son), which have been subset to a small slice of data on chromosome 20 to keep the file sizes small. The sequencing data is in (Binary Alignment Map) format, *i.e*. genome sequencing reads that have already been mapped to the reference genome.
- A list of genomic intervals, *i.e*. coordinates on the genome where our samples have data suitable for calling variants, provided in BED format.

### 0. Warmup: Test the Samtools and GATK commands interactively.

### 1. Write a single-stage workflow that runs Samtools index on a BAM file.

### 2. Add a second process to run GATK HaplotypeCaller on the indexed BAM file.

### 3. Adapt the workflow to run on a batch of samples

### 4. Make the workflow accept a text file containing a batch of input files