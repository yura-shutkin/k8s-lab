# Curl examples

- Exec custom target `without arguments`

    ```shell
    curl -X GET -s -H "X-Webhook-Secret: <WEBHOOK_SECRET>" 'http://<WEBHOOK_ADDR>:<WEBHOOK_PORT>/<WEBHOOK_PREFIX>/target?name=help'
    ```

- Exec custom target `with arguments`

    ```shell
    curl -X GET -s -H "X-Webhook-Secret: <WEBHOOK_SECRET>" -d '{"args": "KIND_CLUSTER_NAME=<CLUSTER_NAME>"}' 'http://<WEBHOOK_ADDR>:<WEBHOOK_PORT>/<WEBHOOK_PREFIX>/target-args?name=kind-show-config'
    ```
