LISTEN_IP=127.0.0.1
CLUSTER_LISTEN_PORT=13000
WEBHOOK_LISTEN_PORT=13001
CLUSTER_NAME=calico

.PHONY: cluster-create
AGENTS=2
MEMORY=4G
cluster-create: ## Create cluster
	@k3d cluster create $(CLUSTER_NAME) --agents $(AGENTS) --agents-memory $(MEMORY) --k3s-arg "--disable=traefik@server:0" --k3s-arg "--flannel-backend=none@server:*" --api-port $(LISTEN_IP):$(CLUSTER_LISTEN_PORT) --volume "$(shell pwd)/$(CLUSTER_NAME).yaml:/var/lib/rancher/k3s/server/manifests/$(CLUSTER_NAME).yaml"

.PHONY: cluster-delete
cluster-delete: ## Delete cluster
	@k3d cluster delete $(CLUSTER_NAME)

.PHONY: cluster-recreate
cluster-recreate: ## Recreate cluster
	@$(MAKE) cluster-delete
	@$(MAKE) cluster-create

.PHONY: cluster-stop
cluster-stop: ## Stop cluster
	@k3d cluster stop $(CLUSTER_NAME)

.PHONY: cluster-start
cluster-start: ## Start cluster
	@k3d cluster start $(CLUSTER_NAME)

.PHONY: cluster-restart
cluster-restart: ## Restart cluster
	@$(MAKE) cluster-stop
	@$(MAKE) cluster-start

.PHONY: cluster-show-config
cluster-show-config: ## Show cluster creds
	@k3d kubeconfig get $(CLUSTER_NAME)

.PHONY: webhook-start
webhook-start: ## Start webhook
	@webhook -hooks hooks.yaml -ip $(LISTEN_IP) -port $(WEBHOOK_LISTEN_PORT) -pidfile webhook.pid -urlprefix '' -hotreload hooks.yaml &

.PHONY: webhook-stop
webhook-stop: ## Stop webhook
	@cat webhook.pid | xargs kill

### Colima (Docker)
.PHONY: colima-create
CPU=2
MEM=6
DNS=8.8.8.8
IP=127.0.0.1
ARCH=x86_64
DISK_SIZE=20
PROFILE=calico-istio
colima-create: ## Create colima VM
	@colima start --cpu $(CPU) --memory $(MEM) --dns $(DNS) --arch $(ARCH) --disk $(DISK_SIZE) --profile $(PROFILE)

.PHONY: colima-delete
PROFILE=calico-istio
colima-delete: ## Delete colima VM
	@colima delete --profile $(PROFILE) --force
