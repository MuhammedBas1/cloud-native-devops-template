resource "aws_lb" "alb" {
    name                = "Load-Balancer"
    internal            = false
    load_balancer_type  = "application"
    subnets             = [aws_subnet.public.id, aws_subnet.public_2.id]
    security_groups     = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "lb_target-group" {
    name        = "target-group for the Load Balancer"
    port        = 80
    protocol    = "tcp"
    vpc_id      = aws_vpc.main.id

    health_check {
        enabled             = true
        path                = "/"
        port                = traffic-port
        protocol            = "tcp"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
    }
}

resource aws_lb_listener" "lb-listener" {
    load_balancer_arn   = aws_lb.alb.arn
    port                = 80
    protocol            = "tcp"

    default_action {
        type                = "forward"
        target_group_arn    = aws_lb_target_group.lb_target-group.arn
    }
}