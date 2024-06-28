# Setup Python Project

This is my development setup for Python projects. It is constantly updated with new settings and tools.

## Creating a project based on this strucutre

1. Clone this repository
2. Copy all the content (except .git folder)

## Running the application locally with Devcontainer (for VSCode users)

Prerequisites:

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker-compose](https://docs.docker.com/compose/install/)

Install libs

```sh
pipenv install --dev
python -m pip install --upgrade pip
pre-commit install
pre-commit install-hooks
```

Create an `.env` file:

```sh
cp .env_template .env
```

### Main commands

Run the application

```sh
make
```

Run the tests

```sh
make test
```

## Running the application locally (alternative for non-VSCode users)

Open terminal inside docker container

```sh
docker-compose run --rm app bash
```

Install dependencies

```sh
pipenv install --dev
```

You will be able to run the same commands to run the application.

## Recommended extensions for vscode

```plain
  "tamasfe.even-better-toml",
  "davidanson.vscode-markdownlint",
  "EditorConfig.EditorConfig",
  "ms-python.python",
  "njpwerner.autodocstring",
  "redhat.vscode-yaml"
```
