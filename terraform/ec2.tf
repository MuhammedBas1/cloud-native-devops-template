resource "aws_security_group" "web" {
    name = "web"
    description = "Allow HTTP and SSH inbound traffic"
    vpc_id = aws_subnet.public.id

    tags = {
        Name = "web"
    }


    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }

    egress {
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
    }
}

//resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
//    security_group_id = aws_security_group.web.id
//    cidr_blocks = ["0.0.0.0/0"]
//    from_port = 80
//    protocol = "tcp"
//    to_port = 80
//}

//resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4 {
//    security_group_id = aws_security_group.web.id
//    cidr_blocks = ["0.0.0.0/0"]
//    from_port = 22
//    protocol = "ssh"
//    to_port = 22
//}

resource "aws_instance" "web" {
    ami = "ami-test"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.web.id]
    associate_public_ip_address = true
    user_data = <<-EOF
    #!/bin/bash
        yum update -y
        yum install -y nginx
        systemctl start nginx
    EOF
}

