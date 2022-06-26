resource "aws_vpc" "kubernetes" {
  cidr_block = "172.31.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
      Name = "K8s-VPC"
  }
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name = "${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "K8s-option-set"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = aws_vpc.kubernetes.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "K8s-igw"
  }
}