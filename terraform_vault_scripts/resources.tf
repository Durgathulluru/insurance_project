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
    export VAULT_ADDR='${local.vault_addr}'
    export DB_CREDENTIALS=$(vault kv get -format=json secrets/terraform/aws/db_credentials | jq -r .data.data)
    export POSTGRES_USER=$(echo $DB_CREDENTIALS | jq -r .POSTGRES_USER)
    export POSTGRES_PASSWORD=$(echo $DB_CREDENTIALS | jq -r .POSTGRES_PASSWORD)
    scp -i ${local.private_key_path} ./docker-compose.yaml ${local.ssh_user}@${aws_instance.capstone.public_ip}:/home/ubuntu/
    ssh -i ${local.private_key_path} ${local.ssh_user}@${aws_instance.capstone.public_ip} <<-EOF
      cd /home/ubuntu/
      if ! which docker-compose; then
        echo "Docker Compose not found!"
        exit 1
      fi
      docker-compose --version
      export POSTGRES_USER=$POSTGRES_USER
      export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
      sudo docker-compose up --build -d
    EOF
    EOT
  }
}
