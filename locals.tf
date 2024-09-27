locals {
  ami_id = "ami-0e86e20dae9224db8"
  vpc_id = "vpc-080ed0fd6d5ed53aa"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "~/insurance/key1" # Path to the private key file
  vault_addr = "http://172.31.88.16:8200"
}
