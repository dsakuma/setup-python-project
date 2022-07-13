.DEFAULT_GOAL := run
.PHONY: run test

run:
	python src/app.py

test:
	pytest -vvs ./tests
