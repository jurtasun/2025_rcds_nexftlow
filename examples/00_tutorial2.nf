// Define input parameters
// params.mode = params.mode ?: error("Provide option\n1: bash, 2: python --mode")
mode = "1"

// Declare process
process hello_bash {
    output:
    """
    #!/usr/bin/bash
    echo "Hello world!"
    """
}

// Declare process
process hello_python {
    output:
    """
    #!/usr/bin/python
    print("Hello world")
    """
}

// Declare process
process choose_option {
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

// // Define workflow
// workflow {

//     // Processes with no input
//     hello_bash()
//     hello_python()
//     choose_option()

//     // Processes with input
//     def num = Channel.of(1, 2, 3)
//     get_files(num)
//     result = print_path(1)
//     result.view { "Result: ${it}" }
//     Channel.of(1, 2, 3).view()

// }

// process blast_all {
//   input:
//   path query_file

//   "blastp -query ${query_file} -db nr"
// }

// workflow {
//     def proteins = Channel.fromPath("home/jurtasun/mnt/network/dataexchange/merkenschlager/genomics/nextseq2000/230503_VH00504_123_AACHC5MM5/*.fastq.gz")
//     blast_all(proteins)
// }

process blast_all {
    input:
    path 'seq'

    "echo seq*"
}

workflow {
    def fastq = Channel.fromPath("home/jurtasun/mnt/network/dataexchange/merkenschlager/genomics/nextseq2000/230503_VH00504_123_AACHC5MM5/*.fastq.gz").buffer(size: 3)
    blast_all(fastq)
}