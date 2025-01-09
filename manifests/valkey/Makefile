################################################################################
### Authentik ##################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

include ../helm.mk

################################################################################
### Helm #######################################################################
################################################################################
REPO_NAME=oci://registry-1.docker.io/bitnamicharts
REPO_URL= #__hidethis__
CHART_NAME=valkey
CHART_VERSION=2.2.1
RELEASE_NAME=valkey
NS=valkey
VALUES_FILE=values.yaml
####

.PHONY: repo-add
repo-add: ##			Add helm repo
	@$(MAKE) custom-message CUSTOM_MESSAGE="Not implemented for OCI proto"

.PHONY: repo-update
repo-update: ##			Update helm repo
	@$(MAKE) custom-message CUSTOM_MESSAGE="Not implemented for OCI proto"

.PHONY: show-versions
show-versions: ##			List helm chart versions
	@$(MAKE) custom-message CUSTOM_MESSAGE="Not implemented for OCI proto"

.PHONY: render-values
render-values: ##			Render values of helm chart
	@$(MAKE) helm-render-values \
		REPO_NAME=$(REPO_NAME) \
		CHART_NAME=$(CHART_NAME) \
		CHART_VERSION=$(CHART_VERSION) \
		VALUES_FILE=$(VALUES_FILE)

.PHONY: install
install: ##			Install helm chart
	@$(MAKE) helm-install \
		NS=$(NS) \
		RELEASE_NAME=$(RELEASE_NAME) \
		REPO_NAME=$(REPO_NAME) \
		CHART_NAME=$(CHART_NAME) \
		CHART_VERSION=$(CHART_VERSION) \
		VALUES_FILE=$(VALUES_FILE)

.PHONY: uninstall
uninstall: ##			Uninstall helm chart
	@$(MAKE) helm-uninstall \
		NS=$(NS) \
		RELEASE_NAME=$(RELEASE_NAME)

.PHONY: diff
diff: ##				Show diff
	@$(MAKE) helm-diff \
		NS=$(NS) \
		VALUES_FILE=$(VALUES_FILE) \
		RELEASE_NAME=$(RELEASE_NAME) \
		REPO_NAME=$(REPO_NAME) \
		CHART_NAME=$(CHART_NAME) \
		CHART_VERSION=$(CHART_VERSION)

.PHONY: render
render: ##			Render chart
	@$(MAKE) helm-template \
		NS=$(NS) \
		VALUES_FILE=$(VALUES_FILE) \
		RELEASE_NAME=$(RELEASE_NAME) \
		REPO_NAME=$(REPO_NAME) \
		CHART_NAME=$(CHART_NAME) \
		CHART_VERSION=$(CHART_VERSION)

################################################################################
### Minikube ###################################################################
################################################################################

.PHONY: fix-storage
fix-storage: ##			Fix storage in minikube
	@kubectl -n ${NS} apply -f minikube-pv-hack
