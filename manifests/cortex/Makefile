################################################################################
### Cortex #################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Prometheus #################################################################
################################################################################
CORTEX_CHART_VERSION=2.1.0
CORTEX_NS=cortex
####

.PHONY: cortex-helm-repo-add
cortex-helm-repo-add: ##		Add metrics-server repo
	@helm repo add cortex https://cortexproject.github.io/cortex-helm-chart
	@helm repo update cortex

.PHONY: cortex-show-versions
cortex-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo cortex -l

.PHONY: cortex-render-values
cortex-render-values: ##		Render values.yaml file
	@helm show values cortex/cortex  --version $(CORTEX_CHART_VERSION) > values.yaml

.PHONY: cortex-install
cortex-install: ##			Install cortex
	@if [ ! -f values.yaml ]; then $(MAKE) cortex-render-values; fi
	-@kubectl create ns $(CORTEX_NS)
	@helm upgrade --install -n $(CORTEX_NS) cortex cortex/cortex  --version $(CORTEX_CHART_VERSION) -f values.yaml

.PHONY: cortex-uninstall
cortex-uninstall: ##		Uninstall cortex
	@helm uninstall -n $(CORTEX_NS) cortex
