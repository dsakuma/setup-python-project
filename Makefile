.DEFAULT_GOAL := run
.PHONY: run test

run:
	python src/app.py

test:
	python -m pytest -vvs ./tests
