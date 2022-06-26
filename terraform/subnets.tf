resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = "172.31.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "K8s-subnet"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.kubernetes.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "K8s-rtb"
  }
}

resource "aws_route" "r0" {
  route_table_id = aws_route_table.rtb.id
  destination_cidr_block = "172.20.0.0/24"
  instance_id = aws_instance.worker-nodes[0].id
}

resource "aws_route" "r1" {
  route_table_id = aws_route_table.rtb.id
  destination_cidr_block = "172.20.1.0/24"
  instance_id = aws_instance.worker-nodes[1].id
}

resource "aws_route" "r2" {
  route_table_id = aws_route_table.rtb.id
  destination_cidr_block = "172.20.2.0/24"
  instance_id = aws_instance.worker-nodes[2].id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rtb.id
}

# resource "aws_route" "r" {
#   route_table_id              = "rtb-4fbb3ac4"
#   destination_ipv6_cidr_block = "::/0"
#   egress_only_gateway_id      = aws_egress_only_internet_gateway.egress.id
# }