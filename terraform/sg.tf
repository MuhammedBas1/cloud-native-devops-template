resource "aws_security_group" "web" {
  name        = "web"
  description = "Allowed Inbound HTTP and SSH traffic for the Web instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web"
  }


  ingress {
    description     = "HTTP from ALB"
    security_groups = [aws_security_group.alb_sg.id]
    //cidr_blocks   = ["0.0.0.0/0"]
    to_port         = 80
    from_port       = 80
    protocol        = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allowed inbound HTTP traffic for the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
  }
}

//resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
//    security_group_id = aws_security_group.web.id
//    cidr_blocks       = ["0.0.0.0/0"]
//    from_port         = 80
//    protocol          = "tcp"
//    to_port           = 80
//}

//resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4 {
//    security_group_id = aws_security_group.web.id
//    cidr_blocks = ["0.0.0.0/0"]
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//}

//resource "aws_instance" "web" {
//    ami = "ami-test"
//    instance_type = "t2.micro"
//    subnet_id = aws_subnet.public.id
//    vpc_security_group_ids = [aws_security_group.web.id]
//    associate_public_ip_address = true
//    iam_instance_profile = aws_iam_instance_profile.web_profile.name
//    user_data = <<-EOF
//    #!/bin/bash
//        yum update -y
//        yum install -y nginx
//        systemctl start nginx
//    EOF
//}