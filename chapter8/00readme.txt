Install homebrew
https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Java development kit (open source implementatio)
https://formulae.brew.sh/formula/openjdk#default
brew install openjdk@21

# Install nextflow
https://www.nextflow.io
java -version
curl -s https://get.nextflow.io | bash

# Check 
echo $PATH
sudo mv nextflow /opt/homebrew/bin/
nextflow run hello
cd /opt/homebrew/bin/ && ./nextflow run hello

# Install docker (outside of HPC)
https://www.docker.com
Move docker.dmg file to 
nextflow run hello -with-docker

# Install singularity (for HPC)
https://docs.sylabs.io/guides/3.5/admin-guide/installation.html
