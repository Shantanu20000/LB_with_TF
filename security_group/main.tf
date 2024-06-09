resource "aws_security_group" "Terraform-sg" {
  name        = "Terrafrom-sg"
  description = "security group allowing traffic on multiple ports"

  vpc_id = var.vpc_id# Replace with your VPC ID

  tags = {
    Name="Terraform-sg"
  }


  # Ingress rules
 dynamic "ingress" {
    for_each = [22, 80, 443, 3306, 8080]
    iterator = port
    content {
      description = "TLC from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
