FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Kevin Alcedo

## Start as root
USER root

## Setup for running behind proxy
# Ignore and comment if you don't need this
# RUN echo 'Acquire::http::proxy "http://proxy.company.com:80";' >> /etc/apt/apt.conf.d/01proxy
# ENV http_proxy http://proxy.company.com:80
# ENV https_proxy http://proxy.company.com:80

## Download OS/Container dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y build-essential curl nano wget git && apt clean 

## Set up environment variables
ENV DEFAULT_USER tyrell_wellick
ENV HOME /home/$DEFAULT_USER
ENV CONDA /opt/conda
ENV PATH $CONDA/bin:$PATH

# Ports to expose
EXPOSE 8888

## Create default user and home directory
RUN useradd --create-home --home-dir /home/$DEFAULT_USER --shell /bin/bash $DEFAULT_USER && \
	adduser $DEFAULT_USER sudo && \
	mkdir -p $CONDA && \
	chown $DEFAULT_USER $CONDA

## Install Python
RUN apt update && apt install -y python-pip python-dev ipython ipython-notebook && apt clean

# Start container session with default user and default home directory
USER $DEFAULT_USER 

## INTSALL MINICONDA AS USER
RUN cd /tmp && \
    mkdir -p $CONDA && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    echo "7097150146dd3b83c805223663ebffcc *Miniconda2-latest-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda2-latest-Linux-x86_64.sh -f -b -p $CONDA && \
    rm Miniconda2-latest-Linux-x86_64.sh && \
    $CONDA/bin/conda config --system --add channels conda-forge && \
    $CONDA/bin/conda config --system --set auto_update_conda false && \
	conda install --quiet --yes conda-build && \
    conda clean -tipsy

# Install Jupyter Notebook
RUN conda install --quiet --yes 'notebook=4.3*' && \
	conda clean -tipsy

# Install scikit-learn
RUN conda install --quiet --yes scikit-learn && \
    conda clean -tipsy

# Install NNabla
RUN pip install -U nnabla_ext_cuda --ignore-installed

# Create a shared volume for notebooks, scripts and data 
RUN mkdir -p /home/$DEFAULT_USER/notebooks
VOLUME /home/$DEFAULT_USER/notebooks/
WORKDIR /home/$DEFAULT_USER

# Get Sony tutorial directory 
RUN git init && \
    git remote add nnabla https://github.com/sony/nnabla.git && \
    git fetch nnabla && \
    git checkout nnabla/master -- tutorial/

# run jupyter notebook
CMD jupyter notebook --no-browser --ip=0.0.0.0 --NotebookApp.token='hellofriend'