################################################################################
### PostgreSQL #################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Helm #######################################################################
################################################################################
CHART_VERSION=6.57.4
NS=grafana
####

.PHONY: helm-repo-add
helm-repo-add: ##		Add metrics-server repo
	@helm repo add grafana https://grafana.github.io/helm-charts
	@helm repo update grafana

.PHONY: show-versions
show-versions: ##		Show versions of grafana helm repo
	@helm search repo grafana -l

.PHONY: render-values
render-values: ##		Render values.yaml file
	@helm show values grafana/grafana  --version $(CHART_VERSION) > values.yaml

.PHONY: create-ns
create-ns: ##			Create NS
	@kubectl create ns ${NS}

.PHONY: install
install: ##		Install grafana
	@if [ ! -f values.yaml ]; then $(MAKE) render-values; fi
	-@$(MAKE) create-ns
	@helm upgrade --install -n $(NS) grafana grafana/grafana --version $(CHART_VERSION) -f values.yaml --create-namespace

.PHONY: uninstall
uninstall: ##		Uninstall grafana
	@helm uninstall -n $(NS) grafana

.PHONY: port-forward
port-forward: ##		Forward operator's port
	@kubectl --namespace grafana port-forward svc/console 3000:3000
	@echo "Visit the Operator Console at http://127.0.0.1:3000"

################################################################################
### Minikube ###################################################################
################################################################################

.PHONY: fix-permissions
fix-permissions: ##		Fix minikube's issue with permissions on Mac OS
	@kubectl apply -f minikube-pv-hack/
