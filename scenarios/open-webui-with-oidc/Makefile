.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)
SCENARIO_NAME=$(shell pwd | xargs basename)# __hidethis__

################################################################################
### Run all ####################################################################
################################################################################

.PHONY: run-all
run-all: ##			Deploy apps
	@$(MAKE) minikube-fix-permissions
	@$(MAKE) contour-install
	@$(MAKE) vault-install
	@$(MAKE) vault-init
	@$(MAKE) vault-unseal
	@$(MAKE) vault-set

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
### ValKey #####################################################################
################################################################################

.PHONY: valkey-helm-chart-update
valkey-helm-chart-update: ##	Add and refresh valkey's helm chart repo
	-@cd ../../manifests/valkey && \
		make repo-add && \
		make repo-update

.PHONY: valkey-install
valkey-install: ##		Install valkey
	@cd ../../manifests/valkey && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/valkey-values.yaml"

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
		make repo-add && \
		make repo-update

.PHONY: vault-install
vault-install: ##			Install vault
	@cd ../../manifests/vault && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/vault-values.yaml"

.PHONY: vault-init
vault-init: ##			Init vault
	@bash ../../scripts/vault_init.sh ${VAULT_URL} ${SHARES} ${THRESHOLD}

.PHONY: vault-unseal
vault-unseal: ##			Unseal vault
	@bash ../../scripts/vault_unseal.sh ${VAULT_URL}

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
### Open WebUI #################################################################
################################################################################

.PHONY: open-webui-helm-chart-update
open-webui-helm-chart-update: ##	Add and refresh open-webui's helm chart repo
	-@cd ../../manifests/open-webui && \
		make repo-add && \
		make repo-update

.PHONY: open-webui-install
open-webui-install: ##		Install open-webui
	@cd ../../manifests/open-webui && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/open-webui-values.yaml"

################################################################################
### Metrics Server #############################################################
################################################################################

.PHONY: metrics-server-helm-chart-update
metrics-server-helm-chart-update: ##Add and refresh metrics-server's helm chart repo
	-@cd ../../manifests/metrics-server && \
		make repo-add && \
		make repo-update

.PHONY: metrics-server-install
metrics-server-install: ##	Install metrics-server
	@cd ../../manifests/metrics-server && \
		make install VALUES_FILE="../../scenarios/${SCENARIO_NAME}/helm_values/metrics-server-values.yaml"
