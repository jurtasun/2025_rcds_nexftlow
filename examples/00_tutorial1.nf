// Define input parameters
params.str = 'Hello world!'

// Declare process split letters
process split_letters {
    output:
    path 'chunk_*'

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}

// Declare process convert to upper
process convert_to_upper {
    input:
    path x

    output:
    stdout

    """
    cat $x | tr '[a-z]' '[A-Z]'
    """
}

// Define workflow
workflow {
    split_letters | flatten | convert_to_upper | view { it.trim() }
}
