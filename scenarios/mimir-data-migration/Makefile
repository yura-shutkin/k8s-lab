.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)
SCENARIO_NAME=$(shell pwd | xargs basename)# __hidethis__

################################################################################
### Run all ####################################################################
################################################################################

.PHONY: run-all
run-all: ##			Deploy apps
	@$(MAKE) contour-install
	@$(MAKE) minio-operator-install
	@$(MAKE) minikube-fix-permissions
	@$(MAKE) minio-tenant-deploy
	@$(MAKE) mimir-install
	@$(MAKE) mimir-deploy-ingresses
	@$(MAKE) mimir-repl-install
	@$(MAKE) mimir-repl-deploy-ingresses
	@$(MAKE) prometheus-install
	@$(MAKE) grafana-install
	@$(MAKE) envoy-deploy

################################################################################
### Minikube ###################################################################
################################################################################

.PHONY: minikube-fix-permissions
minikube-fix-permissions: ##	Fix permissions in minikube localpv
	@kubectl apply -f manifests/minikube-fix-permissions.yaml

################################################################################
### Contour ####################################################################
################################################################################

.PHONY: contour-helm-chart-update
contour-helm-chart-update: ##	Add and refresh contour's helm chart repo
	-@cd ../../manifests/contour && \
		make repo-add && \
		make repo-update

.PHONY: contour-install
contour-install: ##		Install contour
	@cd ../../manifests/contour && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/contour-values.yaml"

################################################################################
### Minio Operator #############################################################
################################################################################

.PHONY: minio-operator-helm-chart-update
minio-operator-helm-chart-update: ##Add and refresh helm chart repo
	-@cd ../../manifests/minio && \
		make repo-add &&\
		make repo-update

.PHONY: minio-operator-install
minio-operator-install: ##	Install MinIO Operator
	@cd ../../manifests/minio && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/minio-operator-values.yaml"

.PHONY: minio-operator-copy-token
minio-operator-copy-token: ##	Copy MinIO Operator token
	@kubectl -n minio get secret console-sa-secret -o json | jq -r '.data.token' | base64 --decode | pbcopy

################################################################################
### Minio Tenant ###############################################################
################################################################################

.PHONY: minio-tenant-deploy
minio-tenant-deploy: ##		Deploy minio-tenant manifest from manifests folder
	@kubectl apply -f manifests/minio.yaml

################################################################################
### Mimir ######################################################################
################################################################################

.PHONY: mimir-helm-chart-update
mimir-helm-chart-update: ##	Add and refresh helm chart repo
	-@cd ../../manifests/mimir && \
		make repo-add &&\
		make repo-update

.PHONY: mimir-install
mimir-install: ##			Install Mimir
	@cd ../../manifests/mimir && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/mimir-values.yaml"

.PHONY: mimir-render
mimir-render: ##			Render helm chart
	@cd ../../manifests/mimir && \
		make render VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/mimir-values.yaml"

.PHONY: mimir-deploy-ingresses
mimir-deploy-ingresses: ##	Deploy Mimir's components ingresses
	@kubectl apply -f manifests/mimir-ingresses.yaml

################################################################################
### Mimir Replica ##############################################################
################################################################################

.PHONY: mimir-repl-install
mimir-repl-install: ##		Install Mimir Replica cluster
	@cd ../../manifests/mimir && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/mimir-repl-values.yaml NS=mimir-repl RELEASE_NAME=mimir-repl"

.PHONY: mimir-repl-render
mimir-repl-render: ##		Render helm chart
	@cd ../../manifests/mimir && \
		make render VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/mimir-values.yaml NS=mimir-repl RELEASE_NAME=mimir-repl"

.PHONY: mimir-repl-deploy-ingresses
mimir-repl-deploy-ingresses: ##	Deploy Mimir repl's components ingresses
	@kubectl apply -f manifests/mimir-repl-ingresses.yaml

################################################################################
### Grafana ####################################################################
################################################################################

.PHONY: grafana-helm-chart-update
grafana-helm-chart-update: ##	Add and refresh vault's helm chart repo
	-@cd ../../manifests/grafana && \
		make repo-add &&\
		make repo-update

.PHONY: grafana-install
grafana-install: ##		Install Grafana
	@cd ../../manifests/grafana && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/grafana-values.yaml CHART_VERSION=8.5.8"

################################################################################
### Prometheus #################################################################
################################################################################

.PHONY: prometheus-helm-chart-update
prometheus-helm-chart-update: ##	Add and refresh vault's helm chart repo
	-@cd ../../manifests/prometheus && \
		make repo-add &&\
		make repo-update

.PHONY: prometheus-install
prometheus-install: ##		Deploy Promerheus
	@cd ../../manifests/prometheus && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/prometheus-values.yaml"

.PHONY: prometheus-envoy-install
prometheus-envoy-install: ##	Deploy Prometheus with remote write to envoy
	@cd ../../manifests/prometheus && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/prometheus-envoy-values.yaml"

################################################################################
### Envoy ######################################################################
################################################################################

.PHONY: envoy-deploy
envoy-deploy: ##			Deploy envoy
	@kubectl apply -f manifests/envoy.yaml
