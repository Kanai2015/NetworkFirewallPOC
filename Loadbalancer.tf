resource "aws_lb" "nfpoc_lb" {
  name               = "nfpoc-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.nfpoc_protected_subnet[*].id
  #subnets            = aws_subnet.nfpoc_public_subnet[*].id

  enable_deletion_protection = false


  tags = {
    Name = "nfpoc_loadbalancer"
  }
}

output "nfpoc_alb" {
  value = aws_lb.nfpoc_lb.dns_name
}



resource "aws_lb_target_group" "nfpoc_lb_tg" {
  name     = "nfpoc-lb-tg"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = aws_vpc.nfpoc.id

}

output "tg_arn" {
  value = aws_lb_target_group.nfpoc_lb_tg.arn

}

output "tg_name" {
  value = aws_lb_target_group.nfpoc_lb_tg.name
}

resource "aws_lb_target_group_attachment" "nfpoc_lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.nfpoc_lb_tg.arn
  target_id        = aws_instance.nfpoc_instance[count.index].id
  port             = var.port
  count=1

}

resource "aws_lb_listener" "nfpoc_listener" {
  load_balancer_arn = aws_lb.nfpoc_lb.arn
  port              = var.port
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nfpoc_lb_tg.arn
  }
}
