locals {
  ami_id = "ami-0866a3c8686eaeeba"
  vpc_id = "vpc-0f8dbf058b5f243e6"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "~/ins/key1" # Path to the private key file
  vault_addr = "http://98.82.210.146:8200"
}
