.DEFAULT_GOAL := run
.PHONY: coverage run test

coverage:
	pytest --cov=./src ./tests

run:
	python src/main.py

test:
	pytest -vvs ./tests
