## RCDS 2025 - Introduction to Nextflow & nf-core

### Dr. Jesús Urtasun Elizari, ICL Research Computing & Data Science

ICL email address `jurtasun@ic.ac.uk`

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

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

Just like in the Hello World example, we want to try out the commands manually before we attempt to wrap them in a workflow. The tools we need (Samtools and GATK) are not installed in the Gitpod environment, but that's not a problem since you learned how to work with containers in Part 2 of this training series (Hello Containers).

#### 0.1. Index a BAM input file with Samtools

We're going to pull down a Samtools container, spin it up interactively and run the `samtools index` command on one of the BAM files.

Pull the Samtools container
```bash
docker pull community.wave.seqera.io/library/samtools:1.20--b5dfbd93de237464
```

Spin up the Samtools container interactively
```bash
docker run -it -v ./data:/data community.wave.seqera.io/library/samtools:1.20--b5dfbd93de237464
```

The Samtools documentation [...] gives us the command line to run to index a BAM file.
We only need to provide the input file; the tool will automatically generate a name for the output by appending .bai to the input filename.

```bash
samtools index /data/bam/reads_mother.bam
```

This should complete immediately, and you should now see a file called `reads_mother.bam.bai` in the same directory as the original BAM input file.

Exit the samtools container
```bash
exit
```

#### 0.2 Call variants with GATK HaplotypeCaller

Pull the GATK container
```bash
docker pull community.wave.seqera.io/library/gatk4:4.5.0.0--730ee8817e436867
```

Spin up the GATK container interactively
```bash
docker run -it -v ./data:/data community.wave.seqera.io/library/gatk4:4.5.0.0--730ee8817e436867
```

The GATK documentation [...] gives us the command line to run to perform variant calling on a BAM file.

We need to provide the BAM input file (-I) as well as the reference genome (-R), a name for the output file (-O) and a list of genomic intervals to analyze (-L).

However, we don't need to specify the path to the index file; the tool will automatically look for it in the same directory, based on the established naming and co-location convention. The same applies to the reference genome's accessory files (index and sequence dictionary files, *.fai and *.dict).
```bash
gatk HaplotypeCaller \
        -R /data/ref/ref.fasta \
        -I /data/bam/reads_mother.bam \
        -O reads_mother.vcf \
        -L /data/ref/intervals.bed
```

The output file `reads_mother.vcf` is created inside your working directory in the container, so you won't see it in the Gitpod file explorer unless you change the output file path. However, it's a small test file, so you can cat it to open it and view the contents. If you scroll all the way up to the start of the file, you'll find a header composed of many lines of metadata, followed by a list of variant calls, one per line.

Each line describes a possible variant identified in the sample's sequencing data. For guidance on interpreting VCF format, see this helpful article [...].

The output VCF file is accompanied by an index file called `reads_mother.vcf.idx` that was automatically created by GATK. It has the same function as the BAM index file, to allow tools to seek and retrieve subsets of data without loading in the entire file.

You know how to test the Samtools indexing and GATK variant calling commands in their respective containers.

We will now learn how to wrap those same commands into a two-step workflow that uses containers to execute the work.


### 1. Write a single-stage workflow that runs Samtools index on a BAM file.

We provide you with a workflow file, `hello-genomics.nf`, that outlines the main parts of the workflow. It's not functional; its purpose is just to serve as a skeleton that you'll use to write the actual workflow.

#### 1.1 Define the indexing process

Let's start by writing a process, which we'll call `SAMTOOLS_INDEX`, describing the indexing operation.

```nextflow
/*
 * Generate BAM index file
 */
process SAMTOOLS_INDEX {

    container 'community.wave.seqera.io/library/samtools:1.20--b5dfbd93de237464'

    publishDir params.outdir, mode: 'symlink'

    input:
        path input_bam

    output:
        path "${input_bam}.bai"

    script:
    """
    samtools index '$input_bam'
    """
}
```

You should recognize all the pieces from what you learned in Part 1 & Part 2 of this training series; the only notable change is that this time we're using `mode: symlink` for the `publishDir` directive, and we're using a parameter to define the `publishDir`.

Note that even though the data files we're using here are very small, in genomics they can get very large. For the purposes of demonstration in the teaching environment, we're using the 'symlink' publishing mode to avoid unnecessary file copies. You shouldn't do this in your final workflows, since you'll lose results when you clean up your work directory.

This process is going to require us to pass in a file path via the `input_bam` input, so let's set that up next.


### 2. Add a second process to run GATK HaplotypeCaller on the indexed BAM file.

At the top of the file, under the `Pipeline parameters` section, we declare a CLI parameter called `reads_bam` and give it a default value. That way, we can be lazy and not specify the input when we type the command to launch the pipeline (for development purposes). We're also going to set `params.outdir` with a default value for the output directory.

```nextflow
/*
 * Pipeline parameters
 */

// Primary input
params.reads_bam = "${projectDir}/data/bam/reads_mother.bam"
params.outdir    = "results_genomics"
```

### 3. Adapt the workflow to run on a batch of samples

### 4. Make the workflow accept a text file containing a batch of input files