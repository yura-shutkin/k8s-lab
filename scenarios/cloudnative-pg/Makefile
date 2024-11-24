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
	@$(MAKE) kps-install
	@$(MAKE) cnpg-op-install
	@$(MAKE) minio-op-install
	@$(MAKE) minikube-fix-permissions
	@$(MAKE) minio-tenant-deploy
	@$(MAKE) cnpg-cluster-deploy
	@$(MAKE) pgsql-srv-deploy
	@$(MAKE) grafana-install

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

################################################################################
### MinIO Tenant ###############################################################
################################################################################

.PHONY: minio-tenant-deploy
minio-tenant-deploy: ##		Deploy CNPG pgsql cluster
	@kubectl apply -f manifests/minio.yaml

.PHONY: minio-tenant-replace
minio-tenant-replace: ##		Redeploy CNPG PGSQL cluster (with replace)
	@kubectl replace -f manifests/minio.yaml

.PHONY: minio-tenant-delete
minio-tenant-delete: ##		Delete CNPG cluster
	@kubectl delete -f manifests/minio.yaml

################################################################################
### CloudNative Cluster ########################################################
################################################################################

.PHONY: cnpg-cluster-deploy
cnpg-cluster-deploy: ##		Deploy CNPG pgsql cluster
	@kubectl apply -f manifests/pgsql-cluster.yaml

.PHONY: cnpg-cluster-replace
cnpg-cluster-replace: ##		Redeploy CNPG PGSQL cluster (with replace)
	@kubectl replace -f manifests/pgsql-cluster.yaml

.PHONY: cnpg-cluster-delete
cnpg-cluster-delete: ##		Delete CNPG cluster
	@kubectl delete -f manifests/pgsql-cluster.yaml

################################################################################
### Simple PGSQL server ########################################################
################################################################################

.PHONY: pgsql-srv-deploy
pgsql-srv-deploy: ##		Deploy standalone PGSQL server
	@kubectl apply -f manifests/pgsql-srv.yaml

.PHONY: pgsql-srv--delete
pgsql-srv--delete: ##		Delete standalone PGSQL server
	@kubectl delete -f manifests/pgsql-srv.yaml

################################################################################
### CloudNative Cluster Replica of PGSQL server ################################
################################################################################

.PHONY: cnpg-cluster-repl-deploy
cnpg-cluster-repl-deploy: ##	Deploy CNPG pgsql cluster from PGSQL server basebackup
	@kubectl apply -f manifests/pgsql-cluster-replica.yaml

.PHONY: cnpg-cluster-repl-replace
cnpg-cluster-repl-replace: ##	Redeploy CNPG pgsql cluster from PGSQL server basebackup (repalce)
	@kubectl replace -f manifests/pgsql-cluster-replica.yaml

.PHONY: cnpg-cluster-repl-delete
cnpg-cluster-repl-delete: ##	Delete CNPG pgsql cluster from PGSQL server basebackup
	@kubectl delete -f manifests/pgsql-cluster-replica.yaml

################################################################################
### CloudNative Cluster Replica of PGSQL server from backup ####################
################################################################################

.PHONY: cnpg-cluster-back-deploy
cnpg-cluster-back-deploy: ##	Deploy CNPG pgsql cluster from precise backup
	@kubectl apply -f manifests/pgsql-cluster-replica.yaml

.PHONY: cnpg-cluster-back-replace
cnpg-cluster-back-replace: ##	Redeploy CNPG PGSQL cluster from precise backup (with replace)
	@kubectl replace -f manifests/pgsql-cluster-replica.yaml

.PHONY: cnpg-cluster-back-delete
cnpg-cluster-back-delete: ##	Delete CNPG cluster from precise backup
	@kubectl delete -f manifests/pgsql-cluster-replica.yaml
