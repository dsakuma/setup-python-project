ARG USERNAME=python

# BASE
FROM python:3.10-slim as base
WORKDIR /app
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV PIPENV_VENV_IN_PROJECT=1
ENV PATH=.venv/bin:$PATH:/home/$USERNAME/.local/bin
RUN apt-get update && \
  apt-get install -y \
  sudo
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME
RUN pip install --user pipenv

# DEV
FROM base as dev
ARG USERNAME
ENV PYRIGHT_PYTHON_FORCE_VERSION=latest
RUN sudo apt-get update && \
  sudo apt-get install -y \
  git \
  make
RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
  && chown -R $USERNAME /home/$USERNAME/.vscode-server \
  && mkdir -p /home/$USERNAME/.cache/pre-commit \
  && chown -R $USERNAME /home/$USERNAME/.cache/pre-commit

# TEST
FROM base as test
ARG USERNAME
COPY --chown=$USERNAME:$USERNAME . /app
RUN pipenv install --dev
CMD ["pytest", "./tests"]

# PROD
FROM base as runtime
ARG USERNAME
COPY --chown=$USERNAME:$USERNAME . /app
RUN pipenv sync
CMD ["python", "src/main.py"]
