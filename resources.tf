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
  instance_type               = "t2.micro"
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
    private_key = local.private_key
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
    command = "ansible-playbook -i myhosts --user ${local.ssh_user} --private-key ${local.private_key} ansible.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo docker build -t insurance:latest .",
      "sudo docker run -d --name insurance_web -p 8080:8080 insurance:latest"
    ]
  }
}
