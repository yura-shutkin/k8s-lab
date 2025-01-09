resource "vault_mount" "project-llm" {
  path = "projects/llm"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "Static secrets for LLM scenario"
}
