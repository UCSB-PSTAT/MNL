FROM jupyter/scipy-notebook

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER root

# Install SSH client and Git
RUN apt-get update && \
    apt-get install -y openssh-client \
                    git \
                    gnupg2 \
                    software-properties-common && \
    apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 && \
    apt-add-repository https://cli.github.com/packages && \
    apt update && \
    apt install gh

USER $NB_UID

RUN conda install -c conda-forge spacy && \
    python -m spacy download en_core_web_sm && \
    pip install https://github.com/medianeuroscience/emfdscore/archive/master.zip && \
    pip install openpyxl

RUN pip install --upgrade jupyterlab && \
    jupyter-lab build
