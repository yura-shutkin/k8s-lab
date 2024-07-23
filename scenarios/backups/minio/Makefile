################################################################################
### MinIO ######################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Helm #######################################################################
################################################################################
CHART_VERSION=5.0.7
NS=minio
####

.PHONY: helm-repo-add
helm-repo-add: ##			Add metrics-server repo
	@helm repo add minio https://operator.min.io/
	@helm repo update minio

.PHONY: show-versions
show-versions: ##			Show versions of minio helm repo
	@helm search repo minio -l

.PHONY: render-values
render-values: ##			Render values.yaml file
	@helm show values minio/operator  --version $(CHART_VERSION) > values.yaml

.PHONY: create-ns
create-ns: ##			Create NS
	@kubectl create ns ${NS}

.PHONY: install
install: ##			Install minio
	@if [ ! -f values.yaml ]; then $(MAKE) render-values; fi
	-@$(MAKE) create-ns
	@helm upgrade --install -n $(NS) minio minio/operator --version $(CHART_VERSION) -f values.yaml --create-namespace

.PHONY: uninstall
uninstall: ##			Uninstall minio
	@helm uninstall -n $(NS) minio

.PHONY: port-forward
port-forward: ##			Forward operator's port
	@kubectl --namespace minio port-forward svc/console 8080:9090
	@echo "Visit the Operator Console at http://127.0.0.1:8080"

.PHONY: get-sa-name
get-sa-name: ##			Get Console SA name
	@kubectl -n ${NS} get sa console-sa -o json | jq -r '.secrets[].name'

.PHONY: get-sa-token
get-sa-token: ##			Get Console SA token
	@kubectl -n ${NS} get secret $(shell $(MAKE) get-sa-name) -o json | jq -r '.data.token' | base64 --decode

.PHONY: mac-copy-sa-token
mac-copy-sa-token: ##		Copy Console SA token to buffer on Mac OS
	@$(MAKE) get-sa-token | pbcopy

################################################################################
### Minikube ###################################################################
################################################################################

.PHONY: fix-permissions
fix-permissions: ##		Fix minikube's issue with permissions on Mac OS
	@kubectl apply -f minikube-pv-hack/
