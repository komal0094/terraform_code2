//lb create
resource "aws_lb" "elb-test" {
  name               = var.elb-name
  internal           = var.bol
  load_balancer_type = var.lb-type
  security_groups    = [var.lb-sg]
  subnets            = var.lb-snets
ip_address_type      = var.ip_address_type


#   enable_deletion_protection = false


  tags = {
    Name = "${terraform.workspace}-dev-elb"
    env = terraform.workspace
  }
}

//lb listener
resource "aws_lb_listener" "elb-listener" {
  load_balancer_arn = aws_lb.elb-test.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elb-tg-001.arn
  }
}

//create tg for lb
resource "aws_lb_target_group" "elb-tg-001" {
  health_check {
    interval = var.interval
    path = "/"
    protocol = "HTTP"
    timeout = var.timeout
    healthy_threshold = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
  name     = "${terraform.workspace}-elb-test"
  port     = 80
  protocol = "HTTP"
  target_type = var.target_type
  vpc_id   = var.vpc_id
}

//create tg attachment to ec2
# resource "aws_lb_target_group_attachment" "elb-tg-attach" {
#    count = length(var.lb-snets)
#    target_group_arn = aws_lb_target_group.elb-tg-001.arn
#    target_id =  var.ec2-attach[count.index]
#   port             = 80
# }