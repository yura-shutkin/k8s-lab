################################################################################
### Vault PKI ##################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

include ../../helm.mk

################################################################################
### cert-manager ###############################################################
################################################################################
CM_REPO_NAME=jetstack
CM_CHART_NAME=cert-manager
CM_CHART_VERSION=v1.14.2
CM_RELEASE_NAME=cert-manager
CM_NS=cert-manager
CM_VALUES_FILE=cm-values.yaml
####

.PHONY: cm-add-repo
cm-add-repo: ##			Add cert-manager helm repo
	@$(MAKE) helm-repo-add REPO_NAME=jetstack REPO_URL=https://charts.jetstack.io

.PHONY: cm-render-values
cm-render-values: ##		Render values of cert-manager's chart
	@$(MAKE) render-values \
		REPO_NAME=$(CM_REPO_NAME) \
		CHART_NAME=$(CM_CHART_NAME) \
		CHART_VERSION=$(CM_CHART_VERSION) \
		VALUES_FILE=$(CM_VALUES_FILE)

.PHONY: cm-install
cm-install: ##			Install cert-manager
	@$(MAKE) install \
		NS=$(CM_NS) \
		RELEASE_NAME=$(CM_RELEASE_NAME) \
		REPO_NAME=$(CM_REPO_NAME) \
		CHART_NAME=$(CM_CHART_NAME) \
		CHART_VERSION=$(CM_CHART_VERSION) \
		VALUES_FILE=$(CM_VALUES_FILE)

.PHONY: cm-uninstall
cm-uninstall: ##			Uninstall chart
	@$(MAKE) uninstall \
		NS=$(CM_NS) \
		RELEASE_NAME=$(CM_RELEASE_NAME)
