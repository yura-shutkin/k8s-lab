# Open WebUI with OIDC

In this scenario you should get:
* Running Authentik service
* Running Ollama service
* Service to upload context files for RAG (?)
* Open WebUI (to communicate with Ollama) with configured OIDC

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
  127.0.0.1 minio.loc
  127.0.0.1 s3.loc
  127.0.0.1 minio.s3.loc
  127.0.0.1 grafana.loc
  127.0.0.1 prom.loc
  127.0.0.1 compactor.mimir.loc
  127.0.0.1 distributor.mimir.loc
  127.0.0.1 ingester.mimir.loc
  127.0.0.1 overrides-exporter.mimir.loc
  127.0.0.1 query-frontend.mimir.loc
  127.0.0.1 query-scheduler.mimir.loc
  127.0.0.1 ruler.mimir.loc
  127.0.0.1 store-gateway.mimir.loc
  127.0.0.1 compactor.mimir-repl.loc
  127.0.0.1 distributor.mimir-repl.loc
  127.0.0.1 ingester.mimir-repl.loc
  127.0.0.1 overrides-exporter.mimir-repl.loc
  127.0.0.1 query-frontend.mimir-repl.loc
  127.0.0.1 query-scheduler.mimir-repl.loc
  127.0.0.1 ruler.mimir-repl.loc
  127.0.0.1 store-gateway.mimir-repl.loc
  ```
- [Optional] pbcopy

## Scenario

1. `T1`: Launch cluster itself (if necessary)
   ```shell
   make minikube-create MINI_NODES_COUNT=1 MINI_CPU=6 MINI_MEM=16G
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
2. Deploy apps
   ```shell
   make run-all
   ```

   You should be able to see the data in http://grafana.loc in explore and in http://ingester.mimir.loc
   ```
   count({__name__=~".+"})
   ```

3. Configure prometheus to write through envoy
   ```shell
   make prometheus-envoy-install
   ```

4. After about 24 hours you may copy historical data and restart compactors on new cluster

## Remarks

* I was not able to migrate historical data without any gaps. The best result was about 30 mins data loss
* Without `host_rewrite_literal` envoy will use `envoy.envoy.svc.cluster.local`
  * With `host_rewrite_literal` set in route, mirrored cluster will see the domain name set in `host_rewrite_literal` + `-shadow` postfix (example.domain.local-shadow)
