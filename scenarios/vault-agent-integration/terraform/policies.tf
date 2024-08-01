data "vault_policy_document" "project-kv_ro" {
  rule {
    path         = "project-kv/data/*"
    capabilities = ["read"]
  }
}

resource "vault_policy" "project-kv_ro" {
  name   = "project-kv_ro"
  policy = data.vault_policy_document.project-kv_ro.hcl
}
