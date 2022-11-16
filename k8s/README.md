# K8S local setup

## K3D

For right now I don't know how to fix eBPF mount in k3d. So latest calico version is `v3.15` for right now

## Minikube

You can use latest version of calico and kubernetes

## Kind

- https://kind.sigs.k8s.io/

## Cilium

* https://docs.cilium.io/

* ```
  make minikube-create CLUSTER_NAME=cilium NODES=3 CNI=cilium
  ``` 
