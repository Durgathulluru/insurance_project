terraform {
  required_version = ">= 1.9.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}
locals {
  ami_id = "ami-0866a3c8686eaeeba"
  vpc_id = "vpc-0f8dbf058b5f243e6"
  ssh_user = "ubuntu"
  key_name = "key1" # This is the name of the key in AWS
  private_key_path = "/var/lib/jenkins/key1" # Full path to the private key file
  vault_addr = "http://98.82.210.146:8200"
}
variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "POSTGRES_USER" {
  description = "Postgres User"
  type        = string
}

variable "POSTGRES_PASSWORD" {
  description = "Postgres Password"
  type        = string
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
resource "aws_security_group" "access" {
  name = "project_security_group"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "capstone" {
  ami                         = local.ami_id
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.access.id]
  key_name                    = local.key_name
  tags = {
    name = "node1"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = local.ssh_user
    private_key = file("${local.private_key_path}")
    timeout     = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'wait for SSH connection to be ready…'",
      "touch /home/ubuntu/demo-file-from-terraform.txt"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > myhosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i myhosts --user ${local.ssh_user} ansible.yaml --private-key ${local.private_key_path}"
  }
}

resource "null_resource" "docker_compose" {
  depends_on = [aws_instance.capstone]

  provisioner "local-exec" {
    command = <<-EOT
    set -x
    scp -i ${local.private_key_path} ./docker-compose.yaml ${local.ssh_user}@${aws_instance.capstone.public_ip}:/home/ubuntu/
    ssh -i ${local.private_key_path} ${local.ssh_user}@${aws_instance.capstone.public_ip} <<-EOF
      cd /home/ubuntu/
      if ! which docker-compose; then
        echo "Docker Compose not found!"
        exit 1
      fi
      docker-compose --version
      export POSTGRES_USER=${var.POSTGRES_USER}
      export POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}
      sudo docker-compose up --build -d
    EOF
    EOT
  }
}
