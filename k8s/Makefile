LISTEN_IP=127.0.0.1
CLUSTER_LISTEN_PORT=13000
WEBHOOK_LISTEN_PORT=13001
CLUSTER_NAME=calico

################################################################################
### Env automation
################################################################################

.PHONY: help
help: ## 			Show this help
	@sed -e '/__hidethis__/d; /##/!d; s/:.##/\t/g' $(MAKEFILE_LIST)

################################################################################
### k3d
################################################################################

.PHONY: cluster-create
AGENTS_COUNT=2
MEMORY=4G
cluster-create: ##		Create cluster
	@k3d cluster create $(CLUSTER_NAME) --agents $(AGENTS_COUNT) --agents-memory $(MEMORY) --k3s-arg "--disable=traefik@server:0" --k3s-arg "--flannel-backend=none@server:*" --api-port $(LISTEN_IP):$(CLUSTER_LISTEN_PORT) --volume "$(shell pwd)/$(CLUSTER_NAME).yaml:/var/lib/rancher/k3s/server/manifests/$(CLUSTER_NAME).yaml"

.PHONY: cluster-delete
cluster-delete: ##		Delete cluster
	@k3d cluster delete $(CLUSTER_NAME)

.PHONY: cluster-recreate
cluster-recreate: ##	Recreate cluster
	@$(MAKE) cluster-stop
	@$(MAKE) cluster-delete
	@$(MAKE) cluster-create

.PHONY: cluster-stop
cluster-stop: ##		Stop cluster
	@k3d cluster stop $(CLUSTER_NAME)

.PHONY: cluster-start
cluster-start: ##		Start cluster
	@k3d cluster start $(CLUSTER_NAME)

.PHONY: cluster-restart
cluster-restart: ##		Restart cluster
	@$(MAKE) cluster-stop
	@$(MAKE) cluster-start

.PHONY: cluster-show-config
cluster-show-config: ##	Show cluster creds
	@k3d kubeconfig get $(CLUSTER_NAME)

################################################################################
### Webhook
################################################################################

.PHONY: webhook-start
webhook-start: ##		Start webhook
	@webhook -hooks hooks.yaml -ip $(LISTEN_IP) -port $(WEBHOOK_LISTEN_PORT) -pidfile webhook.pid -urlprefix '' -hotreload hooks.yaml &

.PHONY: webhook-stop
webhook-stop: ##		Stop webhook
	@cat webhook.pid | xargs kill

################################################################################
### Colima (Docker)
################################################################################

.PHONY: colima-create
CPU=2
MEM=6
DNS=8.8.8.8
IP=127.0.0.1
ARCH=x86_64
DISK_SIZE=20
PROFILE=calico-istio
colima-create: ##		Create colima VM
	@colima start --cpu $(CPU) --memory $(MEM) --dns $(DNS) --arch $(ARCH) --disk $(DISK_SIZE) --profile $(PROFILE)

.PHONY: colima-delete
PROFILE=calico-istio
colima-delete: ##		Delete colima VM
	@colima delete --profile $(PROFILE) --force

################################################################################
### Minikube
################################################################################

.PHONY: minikube-create
NODES_COUNT=2
CPUS=2
minikube-create: ##		Create cluster in minikube
	@minikube -p $(CLUSTE_NAME) start --cpus=$(CPUS) --memory=$(MEMORY) --driver=docker --network-plugin=cni

.PHONY: minikube-delete
minikube-delete: ##		Delete cluster in minikube
	@minikube -p $(CLUSTE_NAME) delete

.PHONY: minikube-stop
minikube-stop: ## 		Stop cluster in minikube
	@minikube -p $(CLUSTE_NAME) stop

.PHONY: minikube-start
minikube-start: ##		Start cluster in minikube
	@minikube -p $(CLUSTE_NAME) start

.PHONY: minikube-pause
minikube-pause: ##		Pause cluster in minikube
	@minikube -p $(CLUSTE_NAME) pause

.PHONY: minikube-unpause
minikube-unpause: ##	Unpause cluster in minikube
	@minikube -p $(CLUSTE_NAME) unpause

################################################################################
### Calico
################################################################################

# __hidethis__ https://projectcalico.docs.tigera.io/archive/v3.22/manifests/calico.yaml
.PHONY: calico-download
CALICO_VERSION=v3.23
calico-download: ##		Download version of calico CALICO_VERSION=v1.22 (yes only major and feature versions)
	@curl https://projectcalico.docs.tigera.io/archive/$(CALICO_VERSION)/manifests/calico.yaml -o calico-$(CALICO_VERSION).yaml

.PHONY: calico-install
calico-install: ##		Install version of calico
	@if [ ! -f "calico-$(CALICO_VERSION).yaml" ]; then $(MAKE) calico-download; fi
	@kubectl apply -f calico-$(CALICO_VERSION).yaml

.PHONY: calico-uninstall
calico-uninstall: ##	Uninstall version of calico
	@kubectl delete -f calico-$(CALICO_VERSION).yaml
