FROM gitpod/workspace-base:latest

USER gitpod

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/miniconda && \
    rm ~/miniconda.sh

# Add conda to path
ENV PATH=$HOME/miniconda/bin:$PATH

# Initialize conda in bash config files:
RUN conda init bash

# Install additional system dependencies if needed
RUN sudo apt-get update && sudo apt-get install -y \
    default-jre \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Copy environment.yml to the image
COPY environment.yml /tmp/environment.yml

# Create conda environment
RUN conda env create -f /tmp/environment.yml && \
    conda clean --all -f -y

# Add conda environment to PATH
ENV PATH /home/gitpod/.conda/envs/gl4u-rnaseq-intro/bin:$PATH

# Activate conda environment
RUN echo "conda activate gl4u-rnaseq-intro" >> ~/.bashrc

# Make sure the environment is activated for non-interactive shells
ENV CONDA_DEFAULT_ENV=gl4u-rnaseq-intro