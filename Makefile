.DEFAULT_GOAL := run
.PHONY: coverage run test

coverage:
	pytest --cov=./src ./tests

run:
	python src/app.py

test:
	pytest -vvs ./tests
