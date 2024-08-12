# TODO

- [ ] **Add proper documentation how to use this repo**
- [ ] Move chart's installation from k8s into manifests
- [ ] Kubernetes dashboard has an error

    ```
    2023/08/06 19:00:34 Getting pod metrics
    2023/08/06 19:00:34 Internal error occurred: No metric client provided. Skipping metrics.
    ```

- [ ] Grafana to view metrics
- [x] Find how to access services and pods. LoadBalancer and DNS resolver

      It is possible to use `minikube tunnel` command and contour to access ingresses inside k8s 
- [x] Brainstorm how to specify scenarios of what we need in local env
- [x] Move release name in Makefile to variable
- [x] Move helm chart repo name in Makefile to variable 
- [x] Move helm chart repo url in Makefile to variable
