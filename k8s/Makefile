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

.PHONY: k3d-create
AGENTS_COUNT=2
MEMORY=4G
k3d-create: ##		Create k3d cluster
	@k3d cluster create $(CLUSTER_NAME) --agents $(AGENTS_COUNT) --agents-memory $(MEMORY) --k3s-arg "--disable=traefik@server:0" --k3s-arg "--flannel-backend=none@server:*" --api-port $(LISTEN_IP):$(CLUSTER_LISTEN_PORT)

.PHONY: k3d-delete
k3d-delete: ##		Delete k3d cluster
	@k3d cluster delete $(CLUSTER_NAME)

.PHONY: k3d-recreate
k3d-recreate: ##		Recreate k3d cluster
	@$(MAKE) k3d-stop
	@$(MAKE) k3d-delete
	@$(MAKE) k3d-create

.PHONY: k3d-stop
k3d-stop: ##		Stop k3d cluster
	@k3d cluster stop $(CLUSTER_NAME)

.PHONY: k3d-start
k3d-start: ##		Start k3d cluster
	@k3d cluster start $(CLUSTER_NAME)

.PHONY: k3d-restart
k3d-restart: ##		Restart k3d cluster
	@$(MAKE) cluster-stop
	@$(MAKE) cluster-start

.PHONY: k3d-show-config
k3d-show-config: ##		Show k3d cluster creds
	@k3d kubeconfig get $(CLUSTER_NAME)

.PHONY: k3d-clusters
k3d-clusters: ##		List k3d clusters
	@k3d cluster list

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
KUBERNETES_VERSION=v1.23.8
CNI_DRIVER=auto
DRIVER=docker
minikube-create: ##		Create cluster in minikube
	@minikube -p $(CLUSTER_NAME) start --cpus=$(CPUS) --nodes=$(NODES_COUNT) --memory=$(MEMORY) --driver=$(DRIVER) --cni=$(CNI_DRIVER) --kubernetes-version=$(KUBERNETES_VERSION)

.PHONY: minikube-delete
minikube-delete: ##		Delete cluster in minikube
	@minikube -p $(CLUSTER_NAME) delete

.PHONY: minikube-recreate
minikube-recreate: ##		Recreate cluster in minikube
	-@$(MAKE) minikube-stop
	-@$(MAKE) minikube-delete
	@$(MAKE) minikube-create

.PHONY: minikube-stop
minikube-stop: ## 		Stop cluster in minikube
	@minikube -p $(CLUSTER_NAME) stop

.PHONY: minikube-start
minikube-start: ##		Start cluster in minikube
	@minikube -p $(CLUSTER_NAME) start

.PHONY: minikube-pause
minikube-pause: ##		Pause cluster in minikube
	@minikube -p $(CLUSTER_NAME) pause

.PHONY: minikube-unpause
minikube-unpause: ##	Unpause cluster in minikube
	@minikube -p $(CLUSTER_NAME) unpause

.PHONY: minikube-profiles
minikube-profiles: ##	Show minikube profiles
	@minikube profile list

################################################################################
### Calico
################################################################################

# __hidethis__ https://projectcalico.docs.tigera.io/archive/v3.22/manifests/calico.yaml
.PHONY: calico-download
CALICO_VERSION=v3.23
calico-download: ##		Download version of calico CALICO_VERSION=v1.22 (yes only major and feature versions)
	@curl https://projectcalico.docs.tigera.io/archive/$(CALICO_VERSION)/manifests/calico.yaml -o calico-$(CALICO_VERSION).yaml

.PHONY: calico-install
calico-install: ##		Install version of calico. You can use CALICO_VERSION=v3.23 to specify version
	@if [ ! -f "calico-$(CALICO_VERSION).yaml" ]; then $(MAKE) calico-download; fi
	@kubectl apply -f calico-$(CALICO_VERSION).yaml

.PHONY: calico-uninstall
calico-uninstall: ##	Uninstall version of calico
	@kubectl delete -f calico-$(CALICO_VERSION).yaml

################################################################################
### Calico
################################################################################
.PHONY: istio-install
istio-install: ##		Install istio
	@istioctl install --set profile=demo -y

.PHONY: istio-uninstall
istio-uninstall: ##		Install istio
	@istioctl uninstall -y
