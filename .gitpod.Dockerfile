FROM gitpod/workspace-base:latest

USER gitpod

# Install conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 \
    && rm Miniconda3-latest-Linux-x86_64.sh

# Add conda to path
ENV PATH=$HOME/miniconda3/bin:$PATH

# Update conda and install mamba
RUN conda update -n base -c defaults conda \
    && conda install -n base -c conda-forge mamba

# Copy environment file
COPY environment.yml /tmp/environment.yml

# Create conda environment
RUN mamba env create -f /tmp/environment.yml \
    && conda clean -afy

# Activate conda environment and install additional packages
SHELL ["/bin/bash", "-c"]
RUN source $HOME/miniconda3/etc/profile.d/conda.sh \
    && conda activate gl4u_rnaseq_2024 \
    && conda install -c conda-forge notebook \
    && pip install jupyter_contrib_nbextensions jupyter_nbextensions_configurator \
    && jupyter contrib nbextension install --user \
    && jupyter nbextension enable --py widgetsnbextension

# Set up JupyterLab to trust all notebooks
RUN mkdir -p ~/.jupyter \
    && echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.password = ''" >> ~/.jupyter/jupyter_notebook_config.py