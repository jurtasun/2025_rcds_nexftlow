// Define input parameters
mode = "1"

// Declare process
process hello_bash {
    input:
    path fastq

    output:
    stdout

    """
    #!/usr/bin/bash
    echo "Hello bash!"
    echo $fastq
    """
}

// Declare process
process hello_python {
    input:
    path fastq

    output:
    stdout

    """
    #!/usr/bin/python
    print("Hello python!")
    """
}

// Declare process
process choose_option {
    output:
    stdout

    script:
    if(mode == "1")
        """
        echo "Mode 1"
        """

    else if(mode == "2")
        """
        echo "Mode 2"
        """
    else
        error "Invalid alignment mode"
}

// Declare process
process get_files {
  input:
  val x

  "echo process job $x"
}

process print_path {
  input:
  val x

  output:
  path 'x.txt'

  """
  echo $x > x.txt
  """
}

// Declare input files
list_files = file("/home/jurtasun/mnt/storage/bioinformatics/users/jurtasun/resources/nextflow/data/*.txt")

// Define workflow
workflow {

    // // Print input
    // print(list_files)
    // Channel.of(list_files) | view()

    // Processes
    hello_bash(list_files) | view()
    hello_python(list_files) | view()
    choose_option() | view()

}