resource "aws_alb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups  =   var.security_group_ids
  subnets            = var.subnet_ids
  enable_deletion_protection = false
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = var.protocol
  vpc_id      = var.vpc_id  
  target_type = "instance"
    health_check {
    enabled             = true
    interval            = 30
    timeout             = 5  
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 2  
    unhealthy_threshold = 2
    matcher             = "200"
  }
}
