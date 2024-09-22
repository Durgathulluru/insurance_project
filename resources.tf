resource "aws_security_group" "access" {
    name = "project_securit_group"
    vpc_id = local.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

     ingress {
        from_port = 80
        to_port   = 80
        protocol =  "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }      

      egress {
         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
         }
}

# aws instance resource block

resource "aws_instance" "capstone" {
          ami = local.ami_id
          instance_type   = "t2.micro"
          associate_public_ip_address = true
          vpc_security_group_ids = [aws_security_group.access.id] 
          key_name = local.key_name
          tags= {
             name= "node1"
             }
          }
