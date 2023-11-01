################################################################################
### Keycloak####################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Prometheus #################################################################
################################################################################
CHART_VERSION=18.4.3
NS=keycloak
####

.PHONY: helm-repo-add
helm-repo-add: ##		Add codecentric repo
	@helm repo add codecentric https://codecentric.github.io/helm-charts
	@helm repo update codecentric

.PHONY: show-versions
show-versions: ##		Show versions of codecentric helm repo
	@helm search repo codecentric -l

.PHONY: render-values
render-values: ##		Render values.yaml file
	@helm show values codecentric/keycloak  --version $(CHART_VERSION) > values.yaml

.PHONY: install
install: ##		Install keycloak
	@if [ ! -f values.yaml ]; then $(MAKE) render-values; fi
	@helm upgrade --install -n $(NS) keycloak codecentric/keycloak --version $(CHART_VERSION) -f values.yaml --create-namespace

.PHONY: uninstall
uninstall: ##		Uninstall minio
	@helm uninstall -n $(NS) minio

.PHONY: fix-storage
fix-storage: ##		Fix storage in minikube
	@kubectl -n ${NS} apply -f minikube-pv-hack

.PHONY: port-forward
port-forward: ##		Forward port
	@kubectl --namespace minio port-forward svc/console 8080:8080
	@echo "Visit the Operator Console at http://127.0.0.1:8080"
