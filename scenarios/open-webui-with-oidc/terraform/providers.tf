terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.2"
    }
  }
}

provider "vault" {
  address   = var.vault_addr
  token     = var.vault_token
  namespace = "root"
}
