#!/usr/bin/env bash

mkdir -p cache_dir
export SINGULARITY_CACHEDIR=$PWD/cache_dir

mkdir -p tmp_dir
export TMPDIR=$PWD/tmp_dir

# see https://github.com/wtsi-hgi/nextflow_crispr_container
rm -f crispr_1.0.sif
singularity pull docker://wtsihgi/crispr:1.0

rm -r cache_dir
rm -r tmp_dir
