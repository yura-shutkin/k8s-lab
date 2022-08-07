SHELL := /bin/bash
DEFAULT_GOAL := help
INFRA_ENV := local
RELEASE_NS := default
RELEASE_NAME := stub-infra
DEBUG := false
PARALLEL_LIMIT := -1

################################################################################
### Stub infra
################################################################################

.PHONY: help
help: ## 			Show this help
	@sed -e '/__hidethis__/d; /##/!d; s/:.##/\t/g' $(MAKEFILE_LIST)

################################################################################
### Werf
################################################################################

.PHONY: werf-render
werf-render: ## 		Render chart
	@werf render --env=$(INFRA_ENV) --namespace=$(RELEASE_NS) --release=$(RELEASE_NAME) --log-debug=$(DEBUG) --parallel-tasks-limit=$(PARALLEL_LIMIT) --dev

.PHONY: werf-apply
werf-apply: ## 		Deploy chart
	@werf converge --env=$(INFRA_ENV) --namespace=$(RELEASE_NS) --release=$(RELEASE_NAME) --log-debug=$(DEBUG) --parallel-tasks-limit=$(PARALLEL_LIMIT) --dev

################################################################################
### Helm
################################################################################
# __hidethis__ helm upgrade [RELEASE] [CHART] [flags]
.PHONY: helm-apply
helm-apply: ## 		Deploy chart
	@cd .helm && \
	helm upgrade --install $(RELEASE_NAME) . --namespace $(RELEASE_NS)
