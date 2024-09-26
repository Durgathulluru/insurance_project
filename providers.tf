provider "aws" {
  region = "us-east-1"
  access_key = data.vault_generic_secret.aws_key.data["aws_key"]
  secret_key = data.vault_generic_secret.aws_pass.data["aws_pass"]
}
provider "vault" {
   address = local.vault_addr
}
