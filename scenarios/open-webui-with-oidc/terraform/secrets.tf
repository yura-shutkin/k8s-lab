resource "random_password" "valkey-password" {
  length  = 20
  special = false
}

resource "vault_generic_secret" "valkey-creds" {
  path = "${vault_mount.project-llm.path}/valkey"
  data_json = jsonencode({
    password = random_password.valkey-password.result
  })
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}
