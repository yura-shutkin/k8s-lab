################################################################################
### Prometheus #################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Prometheus #################################################################
################################################################################
PROM_CHART_VERSION=22.6.2
PROM_NS=prometheus
####

.PHONY: prom-helm-repo-add
prom-helm-repo-add: ##		Add metrics-server repo
	@helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	@helm repo update prometheus-community

.PHONY: prom-show-versions
prom-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo prometheus-community -l

.PHONY: prom-render-values
prom-render-values: ##		Render values.yaml file
	@helm show values prometheus-community/prometheus  --version $(PROM_CHART_VERSION) > values.yaml

.PHONY: prom-install
prom-install: ##			Install prometheus
	@if [ ! -f values.yaml ]; then $(MAKE) prom-render-values; fi
	-@kubectl create ns $(PROM_NS)
	@helm upgrade --install -n $(PROM_NS) prometheus prometheus-community/prometheus  --version $(PROM_CHART_VERSION) -f values.yaml

.PHONY: prom-uninstall
prom-uninstall: ##		Uninstall prometheus
	@helm uninstall -n $(PROM_NS) prometheus
