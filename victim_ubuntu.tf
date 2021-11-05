#Variable Processing
# Setup the userdata that will be used for the instance
data "template_file" "userdata_setup" {
  template = "${file("userdata_setup.template")}"

  vars  = {
    name      = "${var.username}"
    token     = "${var.token}"
    logic = "${file("vuln_bootstrap.sh")}"
  }
}

# Create Security Group for the Application Load Balancer
# terraform aws create security group
resource "aws_security_group" "alb-security-group" {
  name        = "LB AppSec Security Group"
  description = "Allow HTTP/SSH Access on Port 80/22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow HTTP Access on Port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH Access on Port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "LB AppSec Security Group"
  }
}

# Create Security Group for the Bastion Host aka Jump Box
# terraform aws create security group
resource "aws_security_group" "ssh-security-group" {
  name        = "Bastion AppSec Security Group"
  description = "Allow SSH to Bastion"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow SSH to Bastion"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.ssh-location}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Bastion AppSec Security Group"
  }
}

# Create Security Group for the Web Server
# terraform aws create security group
resource "aws_security_group" "webserver-security-group" {
  name        = "Juice-shop Security Group"
  description = "Allow HTTP/HTTPS access on Port 80/443 via ALB and SSH on Port 22 via SG"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow HTTP to Juice Shop"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description      = "Allow 443 to Juice Shop"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description      = "Allow SSH to Juice Shop"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.ssh-security-group.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Juice Shop Security Group"
  }
}

# Create Security Group for the Database
# terraform aws create security group
resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable MYSQL/Aurora on Port 3306"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow MYSQL on port 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.webserver-security-group.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Database Security Group"
  }
}
