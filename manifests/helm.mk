REPO_NAME=# __hidethis__
REPO_URL=# __hidethis__
CHART_VERSION=# __hidethis__
CHART_NAME=# __hidethis__
NS=# __hidethis__
RELEASE_NAME=# __hidethis__
VALUES_FILE=# __hidethis__
####

.PHONY: helm-plugin-diff-install
helm-plugin-diff-install:
	@helm plugin install https://github.com/databus23/helm-diff

.PHONY: helm-show-vars
helm-show-vars: ##			Show vars # __hidethis__
	@echo $(REPO_NAME)

.PHONY: helm-repo-update
helm-repo-update: ##			Update helm repo # __hidethis__
	@helm repo update $(REPO_NAME)

.PHONY: helm-repo-add
helm-repo-add: ##			Add helm repo # __hidethis__
	@helm repo add $(REPO_NAME) $(REPO_URL)
	@$(MAKE) helm-repo-update

.PHONY: helm-show-versions
helm-show-versions: ##			Show versions of chart in helm repo # __hidethis__
	@helm search repo $(REPO_NAME)/$(CHART_NAME) -l

.PHONY: helm-render-values
helm-render-values: ##			Render values.yaml file # __hidethis__
	@helm show values $(REPO_NAME)/$(CHART_NAME) --version $(CHART_VERSION) > $(VALUES_FILE)

.PHONY: helm-install
helm-install: ##			Install chart # __hidethis__
	@if [ ! -f $(VALUES_FILE) ]; then $(MAKE) helm-render-values; fi
	@helm upgrade --install -n $(NS) \
		$(RELEASE_NAME) \
		$(REPO_NAME)/$(CHART_NAME) \
		--version $(CHART_VERSION) \
		-f $(VALUES_FILE) \
		--create-namespace

.PHONY: helm-uninstall
helm-uninstall: ##			Uninstall chart # __hidethis__
	@helm uninstall -n $(NS) $(RELEASE_NAME)

.PHONY: helm-diff
helm-diff: ##			Show helm diff # __hidethis__
	@helm -n $(NS) diff upgrade \
		-f $(VALUES_FILE) \
		--dry-run=server \
		--version $(CHART_VERSION) \
		$(RELEASE_NAME) $(REPO_NAME)/$(CHART_NAME)

.PHONY: helm-template
helm-template: ##			Render helm chart # __hidethis__
	@helm -n $(NS) template \
		-f $(VALUES_FILE) \
		--version $(CHART_VERSION) \
		$(RELEASE_NAME) $(REPO_NAME)/$(CHART_NAME)

.PHONY: kubectl-custom-manifests-apply
kubectl-custom-manifests-apply: ##	Apply custom manifests # __hidethis__
	@kubectl -n $(NS) apply -f custom-manifests
