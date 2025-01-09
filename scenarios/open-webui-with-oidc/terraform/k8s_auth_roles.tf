resource "vault_kubernetes_auth_backend_role" "valkey" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "valkey"
  bound_service_account_names      = ["valkey-primary", "valkey-replica"]
  bound_service_account_namespaces = ["valkey"]
  token_ttl                        = 30
  token_policies = [
    "default",
    "llm-creds-ro"
  ]
}
