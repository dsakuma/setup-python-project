# Setup Python Project

This is a basic structure for Python projects.

## Create a project based in this strucutre

1. Clone this repository
2. Copy all the content (except .git folder)
3. Rename the project in .devcontainer/devcontainer.json

## Setting up the development environment

### Prerequisites

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker-compose](https://docs.docker.com/compose/install/)

### Setup with devcontainer (for VSCode users)

This project is configured with a [devcontainer](https://code.visualstudio.com/docs/remote/containers). When openning the project in VSCode you will be asked to reopen it inside a devcontainer. Just wait the container to be ready (it may take some minutes in the first time) and your local environment will be ready with all dependencies and VSCode extensions installed.

## Main commands

Run the application

```bash
make
```

Run the tests

```bash
make test
```

## Alternative setup with Docker Compose (for non VSCode users)

Open terminal inside docker container

```bash
docker-compose run --rm app bash
```

Install dependencies

```bash
pipenv install --dev
```
