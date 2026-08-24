resource "aws_launch_template" "ec2" {
  name_prefix   = "ec2_web"
  image_id      = "test"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = base64encode(<<-EOF
                #!/bin/bash
                yum update -y
                amazon-linux-extras install nginx1 -y # Oder apt-get install nginx -y je nach AMI
                systemctl start nginx
                systemctl enable nginx
                EOF
  )

  iam_instance_profile {
    name = aws_iam_instance_profile.web_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "EC2_web"
    }
  }
}

resource "aws_autoscaling_group" "asg_web" {
  name             = "asg_web"
  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = [aws_subnet.public.id, aws_subnet.public_2.id]

  target_group_arns = [aws_lb_target_group.lb_target-group.arn]

  launch_template {
    id      = aws_launch_template.ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg_web"
    propagate_at_launch = true
  }
}