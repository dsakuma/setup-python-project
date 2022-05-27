# BASE
FROM python:3.10-slim as base
WORKDIR /app

RUN apt-get update && \
  apt-get install -y \
  sudo

# RUN adduser python sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# RUN usermod python -s /bin/bash

ARG USERNAME=python
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN pip install --user pipenv
ENV PATH=$PATH:/home/python/.local/bin
ENV PATH=.venv/bin:$PATH

# DEV
FROM base as dev
RUN sudo apt-get update && \
  sudo apt-get install -y \
  git \
  make
RUN mkdir -p /home/python/.vscode-server/extensions \
  && chown -R python \
  /home/python/.vscode-server
RUN mkdir -p /home/python/.cache/pre-commit \
  && chown -R python \
  /home/python/.cache/pre-commit

# TEST
FROM base as test
COPY --chown=python:python . /app
RUN pipenv install --dev
CMD ["pytest", "./tests"]

# PROD
FROM base as runtime
COPY --chown=python:python . /app
RUN pipenv sync
CMD ["python", "src/app.py"]
