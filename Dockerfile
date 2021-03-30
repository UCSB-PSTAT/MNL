FROM jupyter/scipy-notebook

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER root

# Install SSH client and Git
RUN apt-get update && \
    apt-get install -y openssh-client \
                    git && \
    apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install -c conda-forge spacy && \
    python -m spacy download en_core_web_sm && \
    pip install https://github.com/medianeuroscience/emfdscore/archive/master.zip && \
    pip install openpyxl

RUN pip install --upgrade jupyterlab && \
    jupyter-lab build
