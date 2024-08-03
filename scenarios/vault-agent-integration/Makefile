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
### Vault ######################################################################
################################################################################
VAULT_URL=http://vault.loc
SHARES=1
THRESHOLD=1
####

.PHONY: vault-helm-chart-update
vault-helm-chart-update: ##	Add and refresh vault's helm chart repo
	-@cd ../../manifests/vault && \
		make repo-add &&\
		make repo-update

.PHONY: vault-install
vault-install: ##			Install vault
	@cd ../../manifests/vault && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/vault-values.yaml"

.PHONY: vault-minikube-fix-storage
vault-minikube-fix-storage: ##	Fix permissions in minikube storage
	@cd ../../manifests/vault && \
		make fix-storage

.PHONY: vault-init
vault-init: ##			Init vault
	@bash ./scripts/vault_init.sh ${VAULT_URL} ${SHARES} ${THRESHOLD}

.PHONY: vault-unseal
vault-unseal: ##			Unseal vault
	@bash ./scripts/vault_unseal.sh ${VAULT_URL}

.PHONY: show-root-token
show-root-token: ##		Copy root token with pbcopy
	@cat creds.json | jq -r '.root_token'

.PHONY: copy-root-token
copy-root-token: ##		Copy root token with pbcopy
	@$(MAKE) show-root-token | pbcopy

.PHONY: vault-set
vault-set: ##			Apply configs to vault
	@$(MAKE) terraform-init
	@$(MAKE) terraform-apply

################################################################################
### Terraform ##################################################################
################################################################################

.PHONY: terraform-init
terraform-init: ##		Init terraform
	@export TF_VAR_vault_addr=${VAULT_URL} &&\
	export TF_VAR_vault_token=$(shell cat creds.json | jq -r '.root_token') &&\
	terraform -chdir=terraform init

.PHONY: terraform-apply
terraform-apply: ##		Apply terraform
	@export TF_VAR_vault_addr=${VAULT_URL} &&\
	export TF_VAR_vault_token=$(shell cat creds.json | jq -r '.root_token') &&\
	terraform -chdir=terraform apply -auto-approve

################################################################################
### WebApp #####################################################################
################################################################################

.PHONY: webapp-install
webapp-install: ##		Install WebApp
	@cd ../../manifests/webapp && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/webapp-values.yaml"

################################################################################
### Secrets Store CSI Driver ###################################################
################################################################################

.PHONY: csi-install
csi-install: ##			Install Secrets Store CSI Driver
	@cd ../../manifests/secrets-store-csi-driver && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/csi-values.yaml"

.PHONY: webapp-csi-install
webapp-csi-install: ##		Install WebApp with CSI driver
	@cd ../../manifests/webapp && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/webapp-csi-values.yaml"
