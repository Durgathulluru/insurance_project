data "vault_generic_secret" "aws_key" {
      path = "secret/aws_key"
}
data "vault_generic_secret" "aws_pass" {
      path = "secret/aws_pass"
}
data "vault_generic_secret" "ssh_key" {
      path = "secret/ssh_key"
}
data "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

