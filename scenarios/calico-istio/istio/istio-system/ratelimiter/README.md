# Istio ratelimit

### Useful commands

- get config `istioctl -n istio-system proxy-config all istio-ingressgateway-77968dbd74-6dnrx --output json | jq '.'`

### Ratelimit docs

- https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/rate_limit_filter

- https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/route/v3/route_components.proto#envoy-v3-api-msg-config-route-v3-ratelimit

- https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/route/v3/route_components.proto.html#route-ratelimit-action

- https://www.aboutwayfair.com/tech-innovation/understanding-envoy-rate-limits

- https://github.com/envoyproxy/ratelimit
