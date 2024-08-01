resource "vault_auth_backend" "kubernetes" {
  type        = "kubernetes"
  path        = "kubernetes"
  description = "Auth backend for auth by JWT from k8s"

  tune {
    max_lease_ttl     = "600s"
    default_lease_ttl = "300s"
  }
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc.cluster.local"
  disable_local_ca_jwt   = "false"
  disable_iss_validation = "true"
}
