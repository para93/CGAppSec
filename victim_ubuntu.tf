# Create Security Group to access web

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow http_ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress = [
    
    {
      description      = "http_ssh to VPC"
      from_port        = 22
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [victim-network-vpc-cidr]  
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]
    
  tags = {
    Name = "allow_http_ssh"
  }
}
