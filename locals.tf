locals {
ami_id = "ami-0ebfd941bbafe70c6"
vpc_id = "vpc-0d7e76b8d5620763d"
ssh_user = "ubuntu"
key_name = "key1" #[this is the name of the key in aws"]
private_key = data.vault_generic_secret.ssh_key.data["ssh_key"]
vault_addr = "http://172.31.41.227:8200"
}
