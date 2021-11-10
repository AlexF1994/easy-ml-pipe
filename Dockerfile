ARG PYTHON_IMAGE_TAG=4.8.2

FROM continuumio/miniconda3:${PYTHON_IMAGE_TAG}

LABEL maintainer="Alexander Fottner"

WORKDIR /easy_ml_pipe
COPY . .

RUN conda config --set channel_priority strict && \
    conda env create -n easy_ml_pipe_env -f environment.yml

# Make RUN commands use the new environment (see: https://pythonspeed.com/articles/activate-conda-dockerfile/)
SHELL ["conda", "run", "-n", "easy_ml_pipe_env", "/bin/bash", "-c"]

RUN python setup.py install

# ENTRYPOINT doesn't use the same shell as RUN so you need the conda stuff
ENTRYPOINT ["conda", "run", "-n", "easy_ml_pipe_env", "python", "-OO", "-m", "easy_ml_pipe"]
