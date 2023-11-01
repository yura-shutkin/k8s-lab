################################################################################
### MinIO ######################################################################
################################################################################

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

################################################################################
### Prometheus #################################################################
################################################################################
MINIO_CHART_VERSION=5.0.6
MINIO_NS=minio
####

.PHONY: minio-helm-repo-add
minio-helm-repo-add: ##		Add metrics-server repo
	@helm repo add minio https://operator.min.io/
	@helm repo update minio

.PHONY: minio-show-versions
minio-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo minio -l

.PHONY: minio-render-values
minio-render-values: ##		Render values.yaml file
	@helm show values minio/operator  --version $(MINIO_CHART_VERSION) > values.yaml

.PHONY: minio-install
minio-install: ##			Install minio
	@if [ ! -f values.yaml ]; then $(MAKE) minio-render-values; fi
	-@kubectl create ns $(MINIO_NS)
	@helm upgrade --install -n $(MINIO_NS) minio minio/operator --version $(MINIO_CHART_VERSION) -f values.yaml --create-namespace

.PHONY: minio-uninstall
minio-uninstall: ##		Uninstall minio
	@helm uninstall -n $(MINIO_NS) minio

.PHONY: minio-port-forward
minio-port-forward: ##		Forward operator's port
	@kubectl --namespace minio port-forward svc/console 9090:9090
	@echo "Visit the Operator Console at http://127.0.0.1:9090"
