-include .env
PWD=$(shell pwd)
.DEFAULT_GOAL := help
APPLICATION_TITLE := Test de charge (avec Taurus) \n ==========

##  -------
##@ Stack
##  -------

start-reset-docker: .reset-docker ## reset volume and start the docker compose stack
	@echo "===> $@ <==="
	@docker volume create db-vol
	@docker compose up -d
.PHONY: start-reset-docker

start-docker: ## start the docker compose stack
	@echo "===> $@ <==="
	@docker compose up -d
.PHONY: start-docker

.reset-docker:
	@echo "===> $@ <==="
	@docker compose down -v
	@docker volume rm db-vol || true
.PHONY: .reset-docker

##  ----
##@ Load test
##  ----

cloud-to-cloud: init ## Run load test scenarios on deployed solution with taurus cloud
	@echo "===> $@ <==="
	@docker run --rm \
	-v $(PWD)/load:/bzt-configs \
	blazemeter/taurus:1.16.26 \
	-o modules.jmeter.properties.api-url=$(API_URL) \
	-o modules.cloud.detach=true \
	-o modules.cloud.workspace=$(BZT_WORKSPACE) \
	-o modules.cloud.project=$(BZT_PROJECT) \
	-o modules.cloud.account=$(BZT_ACCOUNT) \
	-o modules.cloud.test="$(BZT_COMPONENT)-cloud-to-cloud" \
	-o modules.cloud.token=$(BZT_TOKEN) \
	cloud-execution.json  scenarios.json;
	@cd ..
.PHONY: cloud-to-cloud

local-to-cloud: init .revolve-dep ## Run load test scenarios on preprod with taurus local
	@echo "===> $@ <==="
	cd load && \
	python -m bzt \
	 -o modules.jmeter.properties.api-url=$(API_URL) \
	local-execution.json scenarios.json jmeter.yaml;
	@cd ..
.PHONY: local-to-cloud

local-to-local: init .revolve-dep ## Run load test scenario1 on local with taurus local
	@echo "===> $@ <==="
	cd load && \
	python -m bzt \
	 -o modules.jmeter.properties.api-url=http://localhost:8080 \
	local-execution.json scenarios.json jmeter.yaml;
	@cd ..
.PHONY: local-to-local

##  ----
##@ Misc
##  ----

init: ## initialize local env (does not override existing env file)
	@echo "===> $@ <==="
	@cp -n sample.env .env && echo "your .env file has been initialized, fulfill it..." || true
.PHONY: init

.revolve-dep:
	@echo "===> $@ <==="
	@python -m pip install -r requirements.txt
.PHONY: .revolve-dep

.export-env:
	@echo "===> $@ <==="
	@$(eval export $(shell sed -ne 's/ *#.*$$//; /./ s/=.*$$// p' .env))
.PHONY: .export-env

.PHONY: help
# See https://www.thapaliya.com/en/writings/well-documented-makefiles/
help: ## Display this help
	@awk 'BEGIN {FS = ":.* ##"; printf "\n\033[32;1m ${APPLICATION_TITLE}\033[0m\n\n\033[1mUsage:\033[0m\n  \033[31mmake \033[36m<option>\033[0m\n"} /^[%a-zA-Z_-]+:.* ## / { printf "  \033[33m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' ${MAKEFILE_LIST}

##@
