#### rna_seq_container

##### current software versions:  
the versions are saved during docker build in container file `/usr/conda_software_versions.txt`:  
(`docker run wtsihgi/rna_seq:1.0 cat /usr/conda_software_versions.txt`)

For docker tag **1.0**:
```
featureCounts v2.0.2
salmon 1.4.0
STAR 2.7.8a
multiqc, version 1.10.1
QTLtools_1.2_Ubuntu16.04_x86_64
R /opt/conda/envs/conda_rna_seq/bin/R
R version 4.0.3 with libpath "/opt/conda/envs/conda_rna_seq/lib/R/library"
Python 3.9.2 (/opt/conda/envs/conda_rna_seq/bin/python)
```

##### Dockerhub auto-build:  
see https://hub.docker.com/repository/docker/wtsihgi/rna_seq

##### Docker manual build:

```
docker build . # or docker build --tag wtsihgi/rna_seq:1.0 .
docker image ls
docker image tag e682162f5052 wtsihgi/rna_seq:1.0
docker login
docker image push wtsihgi/rna_seq:1.0

# check that conda env is loaded on 'run":
docker run wtsihgi/rna_seq:1.0 conda env list

# check software versions:
docker run wtsihgi/rna_seq:1.0 cat /usr/conda_software_versions.txt

# check that path has conda env bin dir first:
docker run wtsihgi/rna_seq:1.0 printenv
```

##### Convert docker image to singularity:

```
## option 1 (pull first):
singularity pull docker://wtsihgi/rna_seq:1.0
# this creates image file rna_seq_1.0.sif in current dir.

# check conda env is loaded by default (requires --containall):
singularity exec --containall rna_seq_1.0.sif conda env list

## option 2 (single command, exec directly from Dockerhub):
singularity exec --containall docker://wtsihgi/rna_seq:1.0 conda env list

## option 3 (user Docker to create singularity image):
export IMAGE=wtsihgi/rna_seq:1.0
mkdir -p ~/singu &&  rm -rf singu/*.sif
docker run -v /var/run/docker.sock:/var/run/docker.sock -v ~/singu:/output --privileged -t --rm quay.io/singularity/docker2singularity $IMAGE
# check image:
singularity shell --containall singu/wtsihgi_rna_seq_1.0.sif  conda env list
```
