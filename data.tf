data "vault_generic_secret" "access_key" {
      path = "secrets/terraform/aws/accesskey"
}

data "vault_generic_secret" "secret_key" {
      path = "secrets/terraform/aws/secretkey"
}


data "vault_generic_secret" "db_credentials" {
      path = "secrets/terraform/aws/db_credentials"
}
