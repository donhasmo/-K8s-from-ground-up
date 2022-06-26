output "k8s-public-address" {
  value = aws_lb.network-lb.dns_name
}