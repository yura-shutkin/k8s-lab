# Vault Agent kv secret cache

## Prerequisites

- minikube
- docker
- curl
- jq
- make
- kubectl
- helm
- 2 terminal windows:
    - `T1`: terminal for minikube
    - `T2`: (default if `T1` is not specified) terminal for this scenario
- terraform
- 2 records in /etc/hosts (or one if you wish to combine them)
  ```
  127.0.0.1 vault.loc
  127.0.0.1 webapp.loc
  ```
- [Optional] pbcopy

## Scenario

1. `T1`: Launch cluster itself (if necessary)
   ```shell
   make minikube-create MINI_NODES_COUNT=2
   make minikube-tunnel
   ```
   ```
   it could be required to enter your sudo password in order to use 80 and 443 ports
   ```
   ```
   You can specify version of k8s by setting MINI_K8S_VERSION argument
   
   For example:
   make minikube-create MINI_NODES_COUNT=2 MINI_K8S_VERSION=v1.30.0
   ```
2. Deploy Contour
   ```shell
   make contour-helm-chart-update
   make contour-install
   ```
3. Deploy Vault
   ```shell
   make vault-helm-chart-update
   make vault-install
   make vault-minikube-fix-storage
   ```
   ```
   Check terminal with tunnel. You may be required to enter sudo password
   ```
4. Initialize Vault
   ```shell
   make vault-init
   ```
5. Unseal vault
   ```shell
   make vault-unseal
   ```
6. Configure vault
   ```shell
   make vault-set
   ```
7. Deploy web application
   ```shell
   make webapp-install
   ```
   ```
   Check terminal with tunnel. You may be required to enter sudo password
   ```
8. Access vault via http://vault.loc

   You can login with root token.

   For macos (if you have `pbcopy` installed)
   ```shell
   make copy-root-token
   ```
   For other OSes
   ```shell
   make show-root-token
   ```
9. Access WebApp via http://webapp.loc
10. As soon as you got access to webapp you can update secret in vault `project-kv/secret`. After about 4 to 5 minutes you can see the new value in webapp web ui. The new value will be used in webapp. If you wish to lower the interval of update, you can set `token_ttl` in terraform to `30`. In this case the update will happened in about 5s 

## Secrets store CSI driver

* Tutorial: https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-secret-store-driver

1. Install csi driver
   ```shell
   make csi-install
   ```
2. Deploy SecretProviderClass for webapp
   ```shell
   make spc-deploy
   ```
3. Redeploy WebApp application
   ```shell
   make webapp-csi-install
   ```
4. Check the application http://webapp.loc 
