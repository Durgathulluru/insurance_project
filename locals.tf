locals {
  ami_id = "ami-0866a3c8686eaeeba"
  vpc_id = "vpc-04e9a1206569add7b"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "~/.ssh/key1" # Path to the private key file
  vault_addr = "http://172.31.34.60:8200"
}
