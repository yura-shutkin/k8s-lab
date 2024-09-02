################################################################################
### Vault PKI ##################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

include ../helm.mk

################################################################################
### consul #####################################################################
################################################################################
CONSUL_REPO_NAME=hashicorp

CONSUL_CHART_NAME=consul
CONSUL_CHART_VERSION=v1.1.3
CONSUL_RELEASE_NAME=consul
CONSUL_NS=consul
CONSUL_VALUES_FILE=values.yaml
####

.PHONY: add-repo
add-repo: ##			Add cert-manager helm repo
	@$(MAKE) helm-repo-add REPO_NAME=$(CONSUL_REPO_NAME) REPO_URL=$(CONSUL_REPO_URL)

.PHONY: cons-render-values
cons-render-values: ##		Render values of cert-manager's chart
	@$(MAKE) render-values \
		REPO_NAME=$(CONSUL_REPO_NAME) \
		CHART_NAME=$(CONSUL_CHART_NAME) \
		CHART_VERSION=$(CONSUL_CHART_VERSION) \
		VALUES_FILE=$(CONSUL_VALUES_FILE)

.PHONY: cons-install
cons-install: ##			Install cert-manager
	@$(MAKE) install \
		NS=$(CONSUL_NS) \
		RELEASE_NAME=$(CONSUL_RELEASE_NAME) \
		REPO_NAME=$(CONSUL_REPO_NAME) \
		CHART_NAME=$(CONSUL_CHART_NAME) \
		CHART_VERSION=$(CONSUL_CHART_VERSION) \
		VALUES_FILE=$(CONSUL_VALUES_FILE)

.PHONY: cons-uninstall
cons-uninstall: ##			Uninstall chart
	@$(MAKE) uninstall \
		NS=$(CONSUL_NS) \
		RELEASE_NAME=$(CONSUL_RELEASE_NAME)
