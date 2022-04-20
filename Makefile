.PHONY: clean install lint test types docs livedocs

JOBS ?= 1

help:
	@echo "make"
	@echo "    clean"
	@echo "        Remove Python/build artifacts."
	@echo "    install"
	@echo "        Install questionary."
	@echo "    lint"
	@echo "        Check the code style and apply black formatting."
	@echo "    test"
	@echo "        Run the unit tests."
	@echo "    types"
	@echo "        Check for type errors using pytype."
	@echo "    docs"
	@echo "        Build the documentation."
	@echo "    livedocs"
	@echo "        Build the documentation with a live preview for quick iteration."

clean:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +
	rm -rf build/
	rm -rf questionary.egg-info/
	rm -rf .mypy_cache/
	rm -rf .pytest_cache/
	rm -rf dist/

install:
	poetry install --extras "docs"

lint:
	poetry run pre-commit run -a

test:
	poetry run pytest --pycodestyle --cov questionary -v

types:
	poetry run mypy questionary

docs:
	poetry run make -C docs html

livedocs:
	poetry run sphinx-autobuild docs docs/build/html
