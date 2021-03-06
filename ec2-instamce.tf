resource "aws_instance" "juice-shop" {
  ami           = "ami-0629230e074c580f2"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.alb-security-group.id}"]
  key_name = "mchung-dell-pem"
  user_data = "${file("vuln_bootstrap.sh")}"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Juice-Shop-Ubuntu"
  }
}
