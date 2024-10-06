.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)
SCENARIO_NAME=$(shell pwd | xargs basename)# __hidethis__

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
### Kube Prometheus Stack ######################################################
################################################################################

.PHONY: kps-helm-chart-update
kps-helm-chart-update: ##		Add and refresh kps's helm chart repo
	-@cd ../../manifests/kube-prometheus-stack && \
		make repo-add && \
		make repo-update

.PHONY: kps-install
kps-install: ##			Install kps
	@cd ../../manifests/kube-prometheus-stack && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/kube-prom-stack-values.yaml"

.PHONY: kps-fix-storage
kps-fix-storage: ##		Fix storage in minikube
	@cd ../../manifests/kube-prometheus-stack && \
		make fix-storage

################################################################################
### Grafana ####################################################################
################################################################################

.PHONY: grafana-helm-chart-update
grafana-helm-chart-update: ##	Add and refresh grafana's helm chart repo
	-@cd ../../manifests/grafana && \
		make repo-add && \
		make repo-update

.PHONY: grafana-install
grafana-install: ##		Install grafana
	@cd ../../manifests/grafana && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/grafana-values.yaml"

.PHONY: grafana-fix-storage
grafana-fix-storage: ##		Fix storage in minikube
	@cd ../../manifests/grafana && \
		make fix-storage

################################################################################
### CloudNative PG operator ####################################################
################################################################################

.PHONY: cnpg-helm-chart-update
cnpg-helm-chart-update: ##	Refresh helm chart repo
	-@cd ../../manifests/cloudNative-pg && \
		make repo-add &&\
		make repo-update

.PHONY: cnpg-op-install
cnpg-op-install: ##		Install CloudNative PG operator
	@cd ../../manifests/cloudNative-pg && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/cnpg-operator-values.yaml" \
			CHART_NAME=cloudnative-pg \
			NS=cnpg-system

.PHONY: cnpg-op-uninstall
cnpg-op-uninstall: ##		Uninstall CloudNative PG operator
	@cd ../../manifests/cloudNative-pg && \
		make uninstall \
			CHART_NAME=cloudnative-pg \
			NS=cnpg-system

################################################################################
### CloudNative PG operator ####################################################
################################################################################

.PHONY: apply-manifests
apply-manifests: ##		Apply manifests
	@kubectl apply -f manifests

.PHONY: delete-manifests
delete-manifests: ##		Delete manifests
	@kubectl delete -f manifests

################################################################################
### MinIO operator #############################################################
################################################################################

.PHONY: minio-op-install
minio-op-install: ##		Install CloudNative PG operator
	@cd ../../manifests/minio && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/minio-operator-values.yaml"

.PHONY: minio-op-uninstall
minio-op-uninstall: ##		Uninstall CloudNative PG operator
	@cd ../../manifests/minio && \
		make uninstall
