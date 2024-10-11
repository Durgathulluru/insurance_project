locals {
  ami_id = "ami-005fc0f236362e99f"
  vpc_id = "vpc-0f8dbf058b5f243e6"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "/var/lib/jenkins/key1" # Path to the private key file
#  vault_addr = "http://172.31.90.179:8200"
}
