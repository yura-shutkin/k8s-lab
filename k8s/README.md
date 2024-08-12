# K8S local sandbox

In case if you need to easily recreate k8s cluster or launch several clusters

## K3D

* https://k3d.io/

For right now I don't know how to fix eBPF mount in k3d. So latest calico version is `v3.15` for right now

## Webhook

* https://github.com/adnanh/webhook

In case if you used k3d and need access from another machine

## Colima

* https://github.com/abiosoft/colima

In case if you don't want to use docker desktop (win and mac)

## Minikube

* https://minikube.sigs.k8s.io/docs/start/

Launch local cluster via minikube

## Kind

* https://kind.sigs.k8s.io/

Lightweight sandbox

## Calico

* https://projectcalico.docs.tigera.io/getting-started/kubernetes/quickstart

CNI which extends flannel and k8s network policies

## Istio

* https://istio.io/

Replacement for default k8s ingress with a lot of features

## Cilium

* https://docs.cilium.io/

* ```
  make minikube-create CLUSTER_NAME=cilium NODES=3 CNI=cilium
  ```
