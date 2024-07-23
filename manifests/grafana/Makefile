.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

include ../helm.mk

################################################################################
### Grafana ####################################################################
################################################################################
REPO_NAME=grafana
REPO_URL=https://grafana.github.io/helm-charts
CHART_NAME=grafana
CHART_VERSION=6.57.4
RELEASE_NAME=grafana
NS=grafana
VALUES_FILE=values.yaml
####

.PHONY: repo-add
repo-add: ##			Add helm repo
	@$(MAKE) helm-repo-add REPO_NAME=$(REPO_NAME) REPO_URL=$(REPO_URL)

.PHONY: repo-update
repo-update: ##			Update helm repo
	@$(MAKE) helm-repo-update REPO_NAME=$(REPO_NAME)

.PHONY: versions
versions: ##			List helm chart versions
	@$(MAKE) helm-show-versions REPO_NAME=$(REPO_NAME) CHART_NAME=$(CHART_NAME)

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
