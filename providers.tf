provider "aws" {
  region = "us-east-1"
  access_key = data.vault_generic_secret.aws_key.data["access_key"]
  secret_key = data.vault_generic_secret.aws_pass.data["secrete_access_key"]
}
provider "vault" {
   address = "http://172.31.43.136:8200"
}

