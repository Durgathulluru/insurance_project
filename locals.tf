locals {
  ami_id = "ami-0866a3c8686eaeeba"
  vpc_id = "vpc-08c982a26293a6b76"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "/var/lib/jenkins/key1" # Path to the private key file
  vault_addr = "http://44.194.162.10:8200"
}
