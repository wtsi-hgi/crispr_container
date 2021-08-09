FROM mambaorg/micromamba:0.15.2

# apt installs
USER root
# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  r-base r-cran-mvtnorm r-cran-multcomp r-cran-mgcv \
  procps \
  python2.7 \
  build-essential curl git python-pip procps \ 
  manpages-dev g++ gcc gfortran make autoconf automake libtool \
  zlib1g-dev liblzma-dev libbz2-dev lbzip2 libgsl-dev \
  libblas-dev libx11-dev \
  libreadline-dev libxt-dev libpcre2-dev libcurl4-openssl-dev \
  && rm -rf /var/lib/apt/lists/*

# install mamba env
USER micromamba
COPY --chown=micromamba:micromamba env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
    
# add JACKS
ENV MAMBA_ROOT_PREFIX="/opt/conda"
WORKDIR "$MAMBA_ROOT_PREFIX"
RUN git clone https://github.com/felicityallen/JACKS
RUN cd JACKS/jacks && pip install .
ENV PATH "$PATH:$MAMBA_ROOT_PREFIX/JACKS/jacks"
# test that jacks import works in python
RUN python -c 'import sys; import jacks; print(sys.version_info)'

# add R libraries
COPY install_R_libs.R .
RUN Rscript install_R_libs.R
# check R libraries can be loaded:
COPY check_library_loads.R .
RUN Rscript -e "sessionInfo()" >> /opt/conda/r_session_info.txt

# check software versions:
# check that R and python are from conda env by default:
RUN which R >> /opt/conda/conda_software_versions.txt && R --version >> /opt/conda/conda_software_versions.txt
RUN Rscript -e ".libPaths()" >> /opt/conda/conda_software_versions.txt
RUN which python >> /opt/conda/conda_software_versions.txt && python --version >> /opt/conda/conda_software_versions.txt
RUN fastqc -version >> /opt/conda/conda_software_versions.txt
RUN multiqc --version >> /opt/conda/conda_software_versions.txt
RUN bowtie --version >> /opt/conda/conda_software_versions.txt
RUN echo "mageck version:" >> /opt/conda/conda_software_versions.txt && mageck --version >> /opt/conda/conda_software_versions.txt
RUN samtools --version >> /opt/conda/conda_software_versions.txt
RUN cat /opt/conda/conda_software_versions.txt

USER micromamba
WORKDIR /tmp
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/bin/bash"]