# Curl examples

- Exec custom target `without arguments`

  ```shell
  curl -X GET -s -H "X-Webhook-Secret: 54321" 'http://localhost:9000/hooks/target?name=help'
  ```

- Exec custom target `with arguments`

  ```shell
  curl -X POST -s -H "X-Webhook-Secret: 54321" -d "{\"args\": \"KIND_CLUSTER_NAME=laptop\"}" 'http://localhost:9000/hooks/target-args?name=kind-show-config'
  ```

- Update kind cluster config

  ```shell
  cat kind-cluster.yaml
  ```
  ```yaml
  ---
  apiVersion: kind.x-k8s.io/v1alpha4
  kind: Cluster
  name: laptop
  networking:
    ipFamily: ipv4
    apiServerAddress: 0.0.0.0
    apiServerPort: 8443
    podSubnet: "172.16.0.0/16"
  
  nodes:
    - role: control-plane
      image: kindest/node:v1.24.15
    - role: worker
      image: kindest/node:v1.24.15
    - role: worker
      image: kindest/node:v1.24.15
    - role: worker
      image: kindest/node:v1.24.15
      kubeadmConfigPatches:
        - |
          kind: JoinConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "infra=true"
  ```

  ```shell
  curl -X GET -s -H "X-Webhook-Secret: 54321" -d "{\"cluster_name\": \"test\", \"data\": \"$(cat laptop-kind-config.yaml | base64 -b 0)\"}" 'http://localhost:9000/hooks/kind-update-cluster-conf'
  ```
