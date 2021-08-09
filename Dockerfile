FROM continuumio/miniconda3
# the folllowing ARG conda_env variable must match the conda env name defined in environment.yml:
ARG conda_env=crispr

LABEL authors="Guillaume Noell" \
  maintainer="Guillaume Noell <gn5@sanger.ak>" \
  description="Docker image for Crispr Nextflow pipeline"

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  r-base \
  python2.7 \
  build-essential curl git python-pip procps \ 
  g++ gcc gfortran make autoconf automake libtool \
  zlib1g-dev liblzma-dev libbz2-dev lbzip2 libgsl-dev \
  libblas-dev libx11-dev \
  libreadline-dev libxt-dev libpcre2-dev libcurl4-openssl-dev \
  && rm -rf /var/lib/apt/lists/*

RUN which R && R --version
RUN Rscript -e ".libPaths()"
RUN which python3 && python3 --version
RUN which python2 && python2 --version

# update conda && install Conda env:
RUN conda update -n base -c defaults conda
ADD environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

# Set installed Conda env as default:
ENV CONDA_DEFAULT_ENV $conda_env
ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
RUN echo $PATH

# check bin  folder:
RUN ls -ltra /opt/conda/envs/$conda_env/bin

# add R libraries
COPY install_R_libs.R .
RUN Rscript install_R_libs.R

# test R libraries can  be loaded:
RUN Rscript -e "sessionInfo();.libPaths();library(AnnotationHub);library(ensembldb);library(tximport);library(magrittr);library(readr)"

# test python libraries can be loaded:
RUN python -c 'import sys;print(sys.version_info)'

CMD /bin/sh
