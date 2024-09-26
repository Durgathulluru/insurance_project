locals {
ami_id = "ami-0e86e20dae9224db8"
vpc_id = "vpc-0d6910db7a8166812"
ssh_user = "ubuntu"
key_name = "key2" #[this is the name of the key in aws"]
private_key =  file ("~/.ssh/id_ed25519")
vault_addr = "http://172.31.80.224:8200"
}
