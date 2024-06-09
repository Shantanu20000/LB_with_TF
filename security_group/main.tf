variable "vpc_cidr" {
  description = "VPC CIDR Block"
}

variable "public_subnet_cidr_1a" {
  description = "Public Subnet CIDR"
}
variable "public_subnet_cidr_2a" {
  
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
}[root@ip-172-31-6-8 vpc]# cd ../security_group/
[root@ip-172-31-6-8 security_group]# ls
main.tf  output.tf  variable.tf
[root@ip-172-31-6-8 security_group]# cat main.tf 
resource "aws_security_group" "Terraform-sg" {
  name        = "Terrafrom-sg"
  description = "security group allowing traffic on multiple ports"

  vpc_id = var.vpc_id# Replace with your VPC ID

  tags = {
    Name="Terraform-sg"
  }





  # Ingress rules
  dynamic "ingress" {
    for_each = [22,80,443,3000,9090,9100]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allowing traffic from any IPv4 address, you may need to adjust this
    }
  }

  # Egress rules (Allow all traffic out)
  dynamic "egress" {
    for_each = [22,80,443,3000,9090,9100]
        content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allowing traffic from any IPv4 address, you may need to adjust this
    }
    
  }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
}
