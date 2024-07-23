################################################################################
### Local sandbox automation ###################################################
################################################################################
MAKEFLAGS = --no-print-directory # __hidethis__
####

.PHONY: help
help: ## 				Show this help
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

.PHONY: helm-repo-add
helm-repo-add: ## __hidethis__
	@helm repo add $(HELM_REPO_NAME) $(HELM_REPO_URL)
	@helm repo update $(HELM_REPO_NAME)

.PHONY: helm-render-values
helm-render-values: ## __hidethis__
	@helm show values $(CHART_NAME) --version $(CHART_VERSION) > $(VALUES_FILE_NAME)

.PHONY: helm-install
helm-install: ## __hidethis__
	@helm upgrade --install -n $(NS) $(RELEASE_NAME) $(CHART_NAME) --version $(CHART_VERSION) -f $(VALUES_FILE_NAME) --create-namespace

.PHONY: list-clusters
list-clusters: ##			List existed clusters
	@echo "Show K3D clusters:"
	@$(MAKE) k3d-clusters
	@echo "Show minikube clusters/profiles:"
	@$(MAKE) minikube-profiles
	@echo "Show kind clusters:"
	@$(MAKE) kind-list-clusters

################################################################################
### k3d ########################################################################
################################################################################

.PHONY: k3d-create
K3D_CLUSTER_NAME=local
K3D_AGENTS_COUNT=2
K3D_MEM=4G
K3D_LISTEN_IP=127.0.0.1
K3D_CLUSTER_LISTEN_PORT=13000
####

k3d-create: ##			Create k3d cluster
	@k3d cluster create $(K3D_CLUSTER_NAME) --agents $(K3D_AGENTS_COUNT) --agents-memory $(K3D_MEM) --k3s-arg "--disable=traefik@server:0" --k3s-arg "--flannel-backend=none@server:*" --api-port $(K3D_LISTEN_IP):$(K3D_CLUSTER_LISTEN_PORT)

.PHONY: k3d-delete
k3d-delete: ##			Delete k3d cluster
	@k3d cluster delete $(K3D_CLUSTER_NAME)

.PHONY: k3d-recreate
k3d-recreate: ##			Recreate k3d cluster
	@$(MAKE) k3d-stop
	@$(MAKE) k3d-delete
	@$(MAKE) k3d-create

.PHONY: k3d-stop
k3d-stop: ##			Stop k3d cluster
	@k3d cluster stop $(K3D_CLUSTER_NAME)

.PHONY: k3d-start
k3d-start: ##			Start k3d cluster
	@k3d cluster start $(K3D_CLUSTER_NAME)

.PHONY: k3d-restart
k3d-restart: ##			Restart k3d cluster
	@$(MAKE) cluster-stop
	@$(MAKE) cluster-start

.PHONY: k3d-show-config
k3d-show-config: ##		Show k3d cluster creds
	@k3d kubeconfig get $(K3D_CLUSTER_NAME)

.PHONY: k3d-clusters
k3d-clusters: ##			List k3d clusters
	@k3d cluster list

################################################################################
### Webhook ####################################################################
################################################################################

WEBHOOK_LISTEN_IP=127.0.0.1
WEBHOOK_LISTEN_PORT=13001
WEBHOOK_SECRET=54321
WEBHOOK_URL_PREFIX=hooks
WEBHOOK_LOG_FILE=webhook.log
WEBHOOK_CUSTOM_ARGS=""
####

.PHONY: webhook-start
webhook-start: ##			Start webhook
	@WEBHOOK_SECRET=$(WEBHOOK_SECRET) webhook -hooks hooks.yaml -template -ip $(WEBHOOK_LISTEN_IP) -port $(WEBHOOK_LISTEN_PORT) -pidfile webhook.pid -urlprefix $(WEBHOOK_URL_PREFIX) -hotreload -logfile $(WEBHOOK_LOG_FILE) $(WEBHOOK_CUSTOM_ARGS) &

.PHONY: webhook-stop
webhook-stop: ##			Stop webhook
	-@cat webhook.pid | xargs kill

.PHONY: webhook-cleanup-logs
webhook-cleanup-logs: ##		Truncate webhook log file to 0
	@truncate -s 0 $(WEBHOOK_LOG_FILE)

.PHONY: webhook-restart
webhook-restart: ##		Restart webhook
	@$(MAKE) webhook-stop
	@$(MAKE) webhook-start

################################################################################
### Colima (Docker) ############################################################
################################################################################

COLIMA_CPU=2
COLIMA_MEM=6
COLIMA_DNS=8.8.8.8
COLIMA_ARCH=x86_64
COLIMA_DISK_SIZE=20
COLIMA_PROFILE=local
####

.PHONY: colima-create
colima-create: ##			Create colima VM
	@colima start --cpu $(COLIMA_CPU) --memory $(COLIMA_MEM) --dns $(COLIMA_DNS) --arch $(COLIMA_ARCH) --disk $(COLIMA_DISK_SIZE) --profile $(COLIMA_PROFILE)

.PHONY: colima-delete
colima-delete: ##			Delete colima VM
	@colima delete --profile $(COLIMA_PROFILE) --force

################################################################################
### Minikube ###################################################################
################################################################################

MINI_CLUSTER_NAME=local
MINI_NODES_COUNT=2
MINI_CPU=2
MINI_MEM=4G
MINI_K8S_VERSION=v1.23.8
MINI_CNI=auto
MINI_DRIVER=docker
MINI_CIDR=172.16.0.0/16
####

.PHONY: minikube-create
minikube-create: ##		Create cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) start --cpus=$(MINI_CPU) --nodes=$(MINI_NODES_COUNT) --memory=$(MINI_MEM) --driver=$(MINI_DRIVER) --cni=$(MINI_CNI) --extra-config=kubeadm.pod-network-cidr=$(MINI_CIDR) --kubernetes-version=$(MINI_K8S_VERSION)

.PHONY: minikube-delete
minikube-delete: ##		Delete cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) delete

.PHONY: minikube-recreate
minikube-recreate: ##		Recreate cluster in minikube
	-@$(MAKE) minikube-stop
	-@$(MAKE) minikube-delete
	@$(MAKE) minikube-create

.PHONY: minikube-stop
minikube-stop: ## 			Stop cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) stop

.PHONY: minikube-start
minikube-start: ##		Start cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) start

.PHONY: minikube-pause
minikube-pause: ##		Pause cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) pause

.PHONY: minikube-unpause
minikube-unpause: ##		Unpause cluster in minikube
	@minikube -p $(MINI_CLUSTER_NAME) unpause

.PHONY: minikube-profiles
minikube-profiles: ##		Show minikube profiles
	@minikube profile list

.PHONY: minikube-tunnel
minikube-tunnel: ##		Start service to access LB in k8s https://minikube.sigs.k8s.io/docs/handbook/accessing/
	@minikube -p $(MINI_CLUSTER_NAME) tunel

################################################################################
### Kind #######################################################################
################################################################################

KIND_CLUSTER_NAME=local
####

.PHONY: kind-render-config
kind-render-config: ##		Render config for kind
	@export CLUSTER_NAME=$(KIND_CLUSTER_NAME) && \
	envsubst < kind-config.yaml.tpl > $(KIND_CLUSTER_NAME)-kind-config.yaml

.PHONY: kind-list-clusters
kind-list-clusters: ##		List existed clusters
	@kind get clusters

.PHONY: kind-create
kind-create: ##			Create KIND cluster
	@kind create cluster --config $(KIND_CLUSTER_NAME)-kind-config.yaml --name $(KIND_CLUSTER_NAME)

.PHONY: kind-delete
kind-delete: ##			Delete KIND cluster
	@kind delete cluster --name $(KIND_CLUSTER_NAME)

.PHONY: kind-recreate
kind-recreate: ##			Recreate KIND cluster
	@$(MAKE) kind-delete
	@$(MAKE) kind-create

.PHONY: kind-show-config
kind-show-config: ##		Show current kind cluster config
	@kind get kubeconfig --name=$(KIND_CLUSTER_NAME)

################################################################################
### Calico #####################################################################
################################################################################

CALICO_VERSION=v3.23
####

# __hidethis__ https://projectcalico.docs.tigera.io/archive/v3.22/manifests/calico.yaml
.PHONY: calico-download
calico-download: ##		Download version of calico CALICO_VERSION=v1.22 (yes only major and feature versions)
	@curl https://projectcalico.docs.tigera.io/archive/$(CALICO_VERSION)/manifests/calico.yaml -o calico-$(CALICO_VERSION).yaml

.PHONY: calico-install
calico-install: ##		Install version of calico. You can use CALICO_VERSION=v3.23 to specify version
	@if [ ! -f "calico-$(CALICO_VERSION).yaml" ]; then $(MAKE) calico-download; fi
	@kubectl apply -f calico-$(CALICO_VERSION).yaml

.PHONY: calico-uninstall
calico-uninstall: ##		Uninstall version of calico
	@kubectl delete -f calico-$(CALICO_VERSION).yaml

################################################################################
### Calico operator ############################################################
################################################################################

CO_CHART_VERSION=v3.24.5
CO_NS=tigera-operator
####

.PHONY: co-helm-repo-add
co-helm-repo-add: ##		Add helm repo of calico-operator
	@helm repo add projectcalico https://projectcalico.docs.tigera.io/charts
	@helm repo update projectcalico

.PHONY: co-show-versions
co-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo projectcalico -l

.PHONY: co-render-values
co-render-values: ##		Render values.yaml file
	@helm show values projectcalico/tigera-operator --version $(CO_CHART_VERSION) > co_values.yaml

# __hidethis__ https://projectcalico.docs.tigera.io/reference/installation/api
.PHONY: co-install
co-install: ##			Install calico operator
	@if [ ! -f co_values.yaml ]; then $(MAKE) co-render-co-values; fi
	-@kubectl create ns $(CO_NS)
	@helm upgrade --install -n $(CO_NS) calico projectcalico/tigera-operator --version $(CO_CHART_VERSION) -f co_values.yaml

.PHONY: co-uninstall
co-uninstall: ##			Uninstall calico operator
	@helm uninstall -n $(CO_NS) calico

################################################################################
### Istio ######################################################################
################################################################################
.PHONY: istio-install
istio-install: ##			Install istio
	@istioctl install --set profile=demo -y

.PHONY: istio-uninstall
istio-uninstall: ##		Install istio
	@istioctl uninstall -y


################################################################################
### Metrics server #############################################################
################################################################################
MS_CHART_VERSION=3.8.3
MS_NS=metrics-server
####
.PHONY: ms-helm-repo-add
ms-helm-repo-add: ##		Add metrics-server repo
	@helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
	@helm repo update metrics-server

.PHONY: ms-show-versions
ms-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo metrics-server -l

.PHONY: ms-render-values
ms-render-values: ##		Render values.yaml file
	@helm show values metrics-server/metrics-server --version $(MS_CHART_VERSION) > ms_values.yaml

.PHONY: ms-install
ms-install: ##			Install metrics server
	@if [ ! -f ms_values.yaml ]; then $(MAKE) ms-render-values; fi
	-@kubectl create ns $(MS_NS)
	@helm upgrade --install -n $(MS_NS) metrics-server metrics-server/metrics-server --version $(MS_CHART_VERSION) -f ms_values.yaml

.PHONY: ms-uninstall
ms-uninstall: ##			Uninstall metrics server
	@helm uninstall -n $(MS_NS) metrics-server

################################################################################
### Kubernetes Dashboard #######################################################
################################################################################
KD_CHART_VERSION=6.0.8
KD_NS=kube-dash
####
.PHONY: k8s-create-sa
k8s-create-sa: ## __hidethis__
	@kubectl -n ${KD_NS} apply -f admin-sa.yaml

.PHONY: k8s-get-sa-secret
k8s-get-sa-secret: ## __hidethis__
	@kubectl -n ${KD_NS} get sa administrator -o json | jq -r '.secrets[].name'

.PHONY: kd-helm-repo-add
kd-helm-repo-add: ##		Add metrics-server repo
	@helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
	@helm repo update kubernetes-dashboard

.PHONY: kd-show-versions
kd-show-versions: ##		Show versions of projectcalico helm repo
	@helm search repo kubernetes-dashboard -l

.PHONY: kd-render-values
kd-render-values: ##		Render values.yaml file
	@helm show values kubernetes-dashboard/kubernetes-dashboard  --version $(KD_CHART_VERSION) > kube-dash_values.yaml

.PHONY: kd-install
kd-install: ##			Install metrics server
	@if [ ! -f kube-dash_values.yaml ]; then $(MAKE) kd-render-values; fi
	@helm upgrade --install -n $(KD_NS) kube-dash kubernetes-dashboard/kubernetes-dashboard  --version $(KD_CHART_VERSION) -f kube-dash_values.yaml --history-max=2 --create-namespace

.PHONY: kd-uninstall
kd-uninstall: ##			Uninstall metrics server
	@helm uninstall -n $(KD_NS) kube-dash

.PHONY: kd-get-pod-name
kd-get-pod-name: ##		Get kubernetes dashboard pod name
	@kubectl get pods -n kube-dash -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kube-dash" -o jsonpath="{.items[0].metadata.name}"

.PHONY: kd-port-forward
kd-port-forward: ##		Forward port of Kubernetes Dashboard
	echo https://127.0.0.1:8443/
	kubectl -n kube-dash port-forward $(shell make kd-get-pod-name) 8443:8443

.PHONY: kd-get-admin-token
kd-get-admin-token: ##		Get token of admin SA
	@kubectl -n ${KD_NS} get secret $(shell make k8s-get-sa-secret) -o json | jq -r '.data.token' | base64 --decode

################################################################################
### Projectcontour (Ingress controller) ########################################
################################################################################
CNTR_HELM_REPO_NAME=bitnami
CNTR_HELM_REPO_URL=https://charts.bitnami.com/bitnami
CNTR_CHART_VERSION=14.0.2
CNTR_NS=contour
CNTR_VALUES_FILE=cntr-values.yaml
CNTR_RELEASE_NAME=contour
####

.PHONY: cntr-helm-repo-add
cntr-helm-repo-add: ##		Add helm repo for Contourproject
	@$(MAKE) helm-repo-add HELM_REPO_NAME=$(CNTR_HELM_REPO_NAME) HELM_REPO_URL=$(CNTR_HELM_REPO_URL)

.PHONY: cntr-render-values
cntr-render-values: ##		Render chart values of Contourproject
	@$(MAKE) helm-render-values CHART_NAME="$(CNTR_HELM_REPO_NAME)/contour" CHART_VERSION=$(CNTR_CHART_VERSION) VALUES_FILE_NAME=$(CNTR_VALUES_FILE)

.PHONY: cntr-install
cntr-install: ##			Install Contourproject
	@if [ ! -f $(CNTR_VALUES_FILE) ]; then $(MAKE) cntr-render-values; fi
	@$(MAKE) helm-install NS=$(CNTR_NS) RELEASE_NAME=$(CNTR_RELEASE_NAME) CHART_NAME="$(CNTR_HELM_REPO_NAME)/contour" CHART_VERSION=$(CNTR_CHART_VERSION) VALUES_FILE_NAME=$(CNTR_VALUES_FILE)
