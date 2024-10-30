# Chapter 2 - Hello world with nextflow

## Jesús Urtasun Elizari

<img src="/readme_figures/nextflow-logo.png">
<img src="/readme_figures/nf-core-logo.png">

In Chapter 1, you learned how to use the basic building blocks of Nextflow to assemble a simple pipeline capable of processing some text and parallelizing execution if there were multiple inputs.

However, you were limited to basic UNIX tools available in your environment. Real-world tasks often require various tools and packages not included by default. Typically, you'd need to install these tools, manage their dependencies, and resolve any conflicts.

That is all very tedious and annoying, so we're going to show you how to use **containers** to solve this problem much more conveniently.

## 1. Use a container directly

Let's pull a container image that contains the `cowsay` command so we can use it to display some text in a fun way
```bash
docker pull 'community.wave.seqera.io/library/pip_cowsay:131d6a1b707a8e65'
```
The `docker run` command is used to spin up a container instance from a container image and execute a command in it. The `--rm` flag tells Docker to remove the container instance after the command has completed.
```bash
docker run --rm 'community.wave.seqera.io/library/pip_cowsay:131d6a1b707a8e65' cowsay -t "Hello World"
```
You can also run a container interactively, which will give you a shell prompt inside the container.
```bash
docker run --rm -it 'community.wave.seqera.io/library/pip_cowsay:131d6a1b707a8e65' /bin/bash
```
You can see that the filesystem inside the container is different from the filesystem on your host system. Now that you are inside the container, you can run the `cowsay` command directly.
```bash
cowsay -t "Hello World" -c tux
```

To exit the container, you can type `exit` at the prompt or use the Ctrl+D keyboard shortcut..

## 2. Use containers in Nextflow

Nextflow has built-in support for running processes inside containers to let you run tools you don't have installed in your compute environment. This means that you can use any container image you like to run your processes, and Nextflow will take care of pulling the image, mounting the data, and running the process inside it.

## 3. Optional Topic: How to find or make container images

Some software developers provide container images for their software that are available on container registries like Docker Hub, but many do not. In this optional section, we'll show you to two ways to get a container image for tools you want to use in your Nextflow pipelines: using Seqera Containers and building the container image yourself.

You'll be getting/building a container image for the quote pip package, which will be used in the exercise at the end of this section.

### 3.1. Get a container image from Seqera Containers

Seqera Containers is a free service that builds container images for pip and conda (including bioconda) installable tools. Navigate to [https://seqera.io/containers/](Seqera Containers) and search for the `quote` pip package.

### 3.2. Build the container image yourself

Let's use some build details from the Seqera Containers website to build the container image for the `quote` pip package ourselves. Return to the Seqera Containers website and click on the "Build Details" button.

The first item we'll look at is the `Dockerfile`, a type of script file that contains all the commands needed to build the container image. We've added some explanatory comments to the Dockerfile below to help you understand what each part does.

## 4. Bonus Exercise: Make the cow quote famous scientists

This section contains some stretch exercises, to practice what you've learned so far. Doing these exercises is not required to understand later parts of the training, but provide a fun way to reinforce your learnings by figuring out how to make the cow quote famous scientists.

### 4.1. Modify the `hello-containers.nf` script to use a getQuote process

We have a list of computer and biology pioneers in the `containers/data/pioneers.csv` file. At a high level, to complete this exercise you will need to:

### 4.2. Modify your Nextflow pipeline to allow it to execute in `quote` and `sayHello` modes