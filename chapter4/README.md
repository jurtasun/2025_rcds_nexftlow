## LMS 2024 - Introduction to Nextflow & nf-core

### Jesús Urtasun Elizari, LMS Bioinformatics

LMS email address `Jesus.Urtasun@lms.mrc.ac.uk`

ICL email address `jurtasun@ic.ac.uk`

<img src="/readme_figures/nextflow-logo.png">

### Chapter 4. Operators in nextflow

In Part 3, you built a pipeline that was completely linear and processed each sample's data independently of the others. However, in real pipelines, you may need to combine data from multiple samples, or combine different kinds of data. Here we show you how to use channels and channel operators to implement a pipeline with more interesting plumbing.

Specifically, we show you how to implement joint variant calling with **GATK**, building on the pipeline from Part 2.

#### Method overview

The **GATK** variant calling method we used in Part 3 simply generated variant calls per sample. That's fine if you only want to look at the variants from each sample in isolation, but that yields limited information. It's often more interesting to look at variant calls differ across multiple samples, and to do so, GATK offers an alternative method called joint variant calling, which we demonstrate here.

Joint variant calling involves generating a special kind of variant output called GVCF (for Genomic VCF) for each sample, then combining the GVCF data from all the samples and finally, running a 'joint genotyping' statistical analysis.

<img src="/readme_figures/operators1.png">

What's special about a sample's GVCF is that it contains records summarizing sequence data statistics about all positions in the targeted area of the genome, not just the positions where the program found evidence of variation. This is critical for the joint genotyping calculation (further reading).

The GVCF is produced by GATK HaplotypeCaller, the same tool we used in Part 3, with an additional parameter (`-ERC GVCF`). Combining the GVCFs is done with **GATK** GenomicsDBImport, which combines the per-sample calls into a data store (analogous to a database), then the actual 'joint genotyping' analysis is done with **GATK** GenotypeGVCFs.

So to recap, we're going to develop a workflow that does the following:

<img src="/readme_figures/operators2.png">

- Generate an index file for each BAM input file using Samtools
- Run the GATK HaplotypeCaller on each BAM input file to generate a GVCF of per-sample genomic variant calls
- Collect all the GVCFs and combine them into a GenomicsDB data store
- Run joint genotyping on the combined GVCF data store to produce a cohort-level VCF

#### Dataset

- A reference genome consisting of a small region of the human chromosome 20 (from hg19/b37) and its accessory files (index and sequence dictionary).
- Three whole genome sequencing samples corresponding to a family trio (mother, father and son), which have been subset to a small slice of data on chromosome 20 to keep the file sizes small. The sequencing data is in (Binary Alignment Map) format, *i.e*. genome sequencing reads that have already been mapped to the reference genome.
- A list of genomic intervals, *i.e*. coordinates on the genome where our samples have data suitable for calling variants, provided in BED format.

### 0. Warmup: Run Samtools and GATK directly

### 1. Modify the per-sample variant calling step to produce a GVCF

### 2. Collect and combine the GVCF data across all samples

### 3. Run the joint genotyping step as part of the same process