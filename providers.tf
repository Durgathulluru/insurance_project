provider "aws" {
  region = "us-east-1"
  access_key = data.vault_generic_secret.access_key.data["access_key"]
  secret_key = data.vault_generic_secret.secret_key.data["secret_key"]
}
provider "vault" {
   address = "http://98.82.210.146:8200"
}
