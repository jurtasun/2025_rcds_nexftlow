# LMS 2024 - Nextflow & nf-core

## Jesús Urtasun Elizari
## LMS Bioinformatics

<img src="/readme_figures/nextflow-logo.png">
<img src="/readme_figures/nf-core-logo.png">
<img src="/readme_figures/seqera-logo.png">

### Find the content of the course in GitHub:
[https://github.com/jurtasun/2024_nexftlow](https://github.com/jurtasun/2024_nexftlow)

This course provides an introduction to nextflow and nf-core. The topics covered will include basic concepts on bash scripting and linux OS, containers and environments. Then we will show how nextflow can be used to build automatized and reproducible workflows for biological and genomics data analysis.

The course is organized in six chapters, covering topics listed below. All will be followed by a practical session and hands-on coding, both in Python and R. No prior experience on statistics or programming is required for the attendance of this course.

# Roadmap of the course

## Chapter 1. Hello world with nextflow.

- Hello world with nexftlow.

## Chapter 2. Containers: docker & singularity.

- Containers: docker and singularity.

## Chapter 3. Genomics with nexftlow.

- Genomics with nexftlow.

## Chapter 4. Processes, channels, operators.

- Processes, channels, operators.

## Chapter 5. Config, environments, resource usage.

- Modules in nextflow: modular workflow, efficiency and optimization.

## Chapter 6. Test & debug, nf-core and sequera.

- Test and debug a nextflow workflow.
- nf-core: Standardized and reproducible pipelines.
- Sequera platform: cloud running nextflow.

## Setup

We will be working with Visual Studio Code / Gitpod / RStudio as main editors. Although recommended, they do not need to be installed in your local computers, since we will use Codespaces provided by Github, which already implement an interface ready to program an execute the code.
Notebook versions are also useful, such as Jupyter notebooks (for the Python version), or Rmd files (for the R version). 

## Getting Started

1. Download this repository to your computer as a ZIP file and unpack it.

2. Open the terminal and navigate to the unpacked directory to work with the .py / .R examples.

3. Open a Codespace where we will be using either Visual Studio Code / RStudio fro the practical sessions.

## Install and run nextflow locally in your machine

1. Install homebrew
Go to the homebrew site [https://brew.sh](https://brew.sh) and run the following command.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install java development kit (open source implementation of java)
Check the latest jdk relase [https://formulae.brew.sh/formula/openjdk#default](https://formulae.brew.sh/formula/openjdk#default) and run the following command.
```bash
brew install openjdk@21
```

3. Install nextflow
Visit the nextdlow site [https://www.nextflow.io](https://www.nextflow.io) and follow the steps for installation.
Run the following command to check java version.
```bash
java -version
```
Run the following command to download nextflow.
```bash
curl -s https://get.nextflow.io | bash
```
Check the path variable on your computer.
```bash
echo $PATH
```
Here is where all sotfwares installed with homebrew are stored. Move the downloaded `nextflow` executable file there.
```bash
sudo mv nextflow /opt/homebrew/bin/
```
Move to the previous address and run the executable file there.
```bash
cd /opt/homebrew/bin/ && ./nextflow run hello
```
Run the same thing connecting to the `hello` repository of `nextflow`.
```bash
nextflow run hello
```
Congrats! You have nextflow succesfully installed in your computer.

4. Install docker (outside of HPC)
Visit the docker website [https://www.docker.com](https://www.docker.com) and follow the installation instrunctions.
Move docker.dmg file to Applicatinos folder.
Check successfull installation of docker, and run nextflow adding the `-with-docker` argument.
```bash
nextflow run hello -with-docker
```

5. Install singularity (for HPC)
Visit the singularity website [https://docs.sylabs.io/guides/3.5/admin-guide/installation.html](https://docs.sylabs.io/guides/3.5/admin-guide/installation.html) and follow the installation instructions.
Check successfull installation of singulariy.
```bash
nextflow run hello -with-docker
```

## Evaluation

Your feedback is very important to the Graduate School as we are continually trying to improve the training we offer.

At the end of the course, please help us by completing the evaluation form at [...]

<hr>
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
