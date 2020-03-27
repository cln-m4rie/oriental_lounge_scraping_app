default: | help

init: ## initialization
	pip install pipenv && \
	pipenv install

format: ## auto format
	autoflake --in-place --remove-all-unused-imports --remove-unused-variables --recursive src tests && \
		isort -rc src tests && \
		black --line-length 119 src tests

develop: ## install with develop
	pip install --force-reinstall -e .[dev]
	python setup.py develop

run: ## run
	(cd src && python main.py)

dump: ## dump file
	pipenv lock -r > src/requirements.txt

help:  ## Show all of tasks
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
