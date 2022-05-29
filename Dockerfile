# BASE
FROM python:3.10-slim as base
WORKDIR /app

RUN apt-get update && \
  apt-get install -y \
  sudo

ARG USERNAME=python
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN pip install --user pipenv
ENV PATH=$PATH:/home/$USERNAME/.local/bin
ENV PATH=.venv/bin:$PATH

# DEV
FROM base as dev
RUN sudo apt-get update && \
  sudo apt-get install -y \
  git \
  make
RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
  && chown -R $USERNAME \
  /home/$USERNAME/.vscode-server
RUN mkdir -p /home/$USERNAME/.cache/pre-commit \
  && chown -R $USERNAME \
  /home/$USERNAME/.cache/pre-commit

# TEST
FROM base as test
COPY --chown=$USERNAME:$USERNAME . /app
RUN pipenv install --dev
CMD ["pytest", "./tests"]

# PROD
FROM base as runtime
COPY --chown=$USERNAME:$USERNAME . /app
RUN pipenv sync
CMD ["python", "src/app.py"]
