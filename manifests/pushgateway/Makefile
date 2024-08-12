.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

include ../helm.mk

################################################################################
### Pushgateway ################################################################
################################################################################
REPO_NAME=prometheus-community
REPO_URL=https://prometheus-community.github.io/helm-charts
CHART_NAME=prometheus-pushgateway
CHART_VERSION=2.6.0
RELEASE_NAME=pgw
NS=pgw
VALUES_FILE=values.yaml
####

.PHONY: repo-add
repo-add: ##			Add helm repo
	@$(MAKE) helm-repo-add REPO_NAME=$(REPO_NAME) REPO_URL=$(REPO_URL)

.PHONY: repo-update
repo-update: ##			Update helm repo
	@$(MAKE) helm-repo-update REPO_NAME=$(REPO_NAME)

.PHONY: show-versions
show-versions: ##			List helm chart versions
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
