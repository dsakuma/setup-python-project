#!/bin/sh

pipenv install --dev
python -m pip install --upgrade pip
pre-commit install
pre-commit install-hooks
