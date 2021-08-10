mkdir -p ./singu

docker run -v /var/run/docker.sock:/var/run/docker.sock \
-v ~/singu:/output \
--privileged -t --rm \
quay.io/singularity/docker2singularity \
wtsihgi/crispr:74c1a3d

# singularity image will now be in ./singu directory

# mkdir -p cache_dir
# export SINGULARITY_CACHEDIR=$PWD/cache_dir=
# mkdir -p tmp_dir
# export TMPDIR=$PWD/tmp_dir
# see https://github.com/wtsi-hgi/nextflow_crispr_container
# rm -f crispr_1.0.sif
# singularity pull docker://wtsihgi/crispr:1.0
# rm -r cache_dir
# rm -r tmp_dir
