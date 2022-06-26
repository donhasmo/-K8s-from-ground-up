resource "aws_lb" "network-lb" {
  name = "K8s-nlb"
  load_balancer_type = "network"
  subnets = [aws_subnet.subnet.id]
}

resource "aws_lb_target_group" "network-tg" {
  name     = "network-tg"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.kubernetes.id

  health_check {
    interval = 30
    port = 6443
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "master-nodes-tg-attach" {
  count = var.number_of_master_nodes
  target_group_arn = aws_lb_target_group.network-tg.arn
  target_id        = aws_instance.master-nodes[count.index].id
  port             = "6443"
}

#Listener rule

resource "aws_lb_listener" "worker-nodes-listener" {
  load_balancer_arn = aws_lb.network-lb.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.network-tg.arn
  }
}

