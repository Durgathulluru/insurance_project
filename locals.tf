locals {
ami_id = "ami-080e1f13689e07408"
vpc_id = "vpc-048db6e177c9b2ba7"
ssh_user = "ubuntu"
key_name = "key1" #[this is the name of the key in aws"]
private_key = data.vault_generic_secret.ssh_key.data["private_key"]
}
