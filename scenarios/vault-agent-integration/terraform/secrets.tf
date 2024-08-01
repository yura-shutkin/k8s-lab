resource "vault_generic_secret" "project-kv-secret" {
  path = "${vault_mount.project-kv.path}/secret"
  data_json = jsonencode({
    value = "12345"
  })
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}
