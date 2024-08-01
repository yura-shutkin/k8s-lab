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
    - T1: terminal for minikube
    - T2: terminal for this scenario
- terraform
- 2 records in /etc/hosts (or one if you wish to combine them)
  ```
  127.0.0.1 vault.loc
  127.0.0.1 webapp.loc
  ```

## Scenario

1. T1: Launch cluster itself (if necessary)
   ```
   make minikube-create MINI_NODES_COUNT=2
   make minikube-tunnel
   ```
   ```
   it could be required to enter your sudo password in order to use 80 and 443 ports
   ```
2. T2: Deploy Contour
   ```
   make contour-install
   ```
3. T2: Deploy Vault
   ```
   make vault-install
   make vault-minikube-fix-storage
   ```
   ```
   Check terminal with tunnel. You may be required to enter sudo password
   ```
4. T3: Initialize Vault
   ```
   make vault-init
   ```
5. Unseal vault
   ```
   make vault-unseal
   ```
6. Configure vault
   ```
   make vault-set
   ```
7. Deploy web application
   ```
   make webapp-install
   ```
   ```
   Check terminal with tunnel. You may be required to enter sudo password
   ```
8. Access vault via http://vault.loc

   You can login with root token.

   For macos
   ```
   make copy-root-token
   ```
   For other OSes
   ```
   make show-root-token
   ```
9. Access WebApp via http://webapp.loc
10. As soon as you got access to webapp you can update secret in vault `project-kv/secret`. After about 4 to 5 minutes you can see the new value in webapp web ui. The new value will be used in webapp. If you wish to lower the interval of update, you can set `token_ttl` in terraform to `30`. In this case the update will happened in about 5s 
