MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := dev

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

HOST=http://localhost
PORT=1313

# .env
ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

install: ## Install Npm package
	@npm install

dev: ## Run server by Npm
	@npm run dev

serve: ## Run server
	@hugo server --bind="0.0.0.0" --baseUrl="${HOST}" --port=${PORT} --buildDrafts --watch

serve-without-draft: ## Run server without draft posts
	@hugo server --watch

build: clean ## Build static html
	@npm run build

build-only: clean ## Build static html
	@hugo

clean: ## Clean old files
	@hugo --cleanDestinationDir
	rm -fr public/*

deploy: build ## Deploy on Github Pages
	@git add .
	@git commit -m 'modified'
	@git push

github-api: ## Run github api
	@curl -X POST \
	-H "Accept: application/vnd.github.everest-preview+json" \
	-H "Authorization: token ${GITHUB_TOKEN}" \
	-d '{"event_type": "Wehook test"}' \
	https://api.github.com/repos/${GITHUB_ACCOUNT}/${GITHUB_REPO}/dispatches

github-api-with-header: ## Run github api with header
	@curl -X POST -i \
	-H "Accept: application/vnd.github.everest-preview+json" \
	-H "Authorization: token ${GITHUB_TOKEN}" \
	-d '{"event_type": "Wehook test"}' \
	https://api.github.com/repos/${GITHUB_ACCOUNT}/${GITHUB_REPO}/dispatches

contentful-webhook: ## Run contentful webhook
	@curl "https://cdn.contentful.com/spaces/${CONTENTFUL_SPACE}/entries?order=-sys.createdAt&content_type=${CONTENTFUL_CONTENT_TYPE}&access_token=${CONTENTFUL_TOKEN}"

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
