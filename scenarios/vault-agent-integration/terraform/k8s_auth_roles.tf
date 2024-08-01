resource "vault_kubernetes_auth_backend_role" "webapp" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "webapp"
  bound_service_account_names      = ["webapp"]
  bound_service_account_namespaces = ["webapp"]
  token_ttl                        = 30
  token_policies = [
    "default",
    vault_policy.project-kv_ro.name
  ]
}
