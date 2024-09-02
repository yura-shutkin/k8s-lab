################################################################################
### MinIO ######################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Prometheus #################################################################
################################################################################
MIMIR_CHART_VERSION=5.1.3
MIMIR_NS=mimir
####

.PHONY: helm-repo-add
helm-repo-add: ##		Add metrics-server repo
	@helm repo add grafana https://grafana.github.io/helm-charts
	@helm repo update grafana

.PHONY: show-versions
show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo grafana/mimir-distributed -l

.PHONY: render-values
render-values: ##		Render values.yaml file
	@helm show values grafana/mimir-distributed  --version $(MIMIR_CHART_VERSION) > values.yaml

.PHONY: install
install: ##			Install minio
	@if [ ! -f values.yaml ]; then $(MAKE) render-values; fi
	@helm upgrade --install -n $(MIMIR_NS) mimir grafana/mimir-distributed --version $(MIMIR_CHART_VERSION) -f values.yaml --create-namespace

.PHONY: uninstall
uninstall: ##		Uninstall minio
	@helm uninstall -n $(MIMIR_NS) mimir
