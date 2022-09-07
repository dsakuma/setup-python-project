# Setup Python Project

This is my development setup for Python projects. It is constantly updated with new settings and tools.

## Creating a project based in this strucutre

1. Clone this repository
2. Copy all the content (except .git folder)
3. Rename the project in .devcontainer/devcontainer.json

## Running the application locally with Devcontainer (for VSCode users)

### Prerequisites

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker-compose](https://docs.docker.com/compose/install/)
- Install [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VSCode

### Start devcontainer

This project is configured with a devcontainer. When openning the project in VSCode you will be asked to reopen it inside a devcontainer. Just wait the container to be ready (it may take some minutes in the first time) and your local environment will be ready with all dependencies and VSCode extensions installed.

### Main commands

Run the application

```bash
make
```

Run the tests

```bash
make test
```

## Running the application locally (alternative for non-VSCode users)

Open terminal inside docker container

```bash
docker-compose run --rm app bash
```

Install dependencies

```bash
pipenv install --dev
```

You will be able to run the same commands to run the application.
