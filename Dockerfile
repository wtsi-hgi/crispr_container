FROM continuumio/miniconda3

LABEL authors="Guillaume Noell" \
  maintainer="Guillaume Noell <gn5@sanger.ak>" \
  description="Docker image containing all requirements for WSTI-HGI scRNA cellSNP-Vireo deconvolution pipeline"

# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  libbz2-dev \
  python-pip \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# install Conda env
ADD environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml
# Pull the environment name out of the environment.yml
RUN echo "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin:$PATH

RUN pip install cellSNP
RUN pip install vireoSNP # ==0.1.1

CMD /bin/sh
