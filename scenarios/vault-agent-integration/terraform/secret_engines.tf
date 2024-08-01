resource "vault_mount" "project-kv" {
  path = "project-kv"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "Static secrets"
}
