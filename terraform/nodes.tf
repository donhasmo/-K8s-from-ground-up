# Key Pair
resource "aws_instance" "master-nodes" {
  count         = var.number_of_master_nodes
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = "k8s"
  private_ip    = "172.31.0.1${count.index}"
  subnet_id = aws_subnet.subnet.id
  security_groups = [aws_security_group.sg.id, aws_default_security_group.default.id]
  source_dest_check = false

  tags = {
    Name  = "Master-node-${count.index}"
  }
}

resource "aws_instance" "worker-nodes" {
  count         = var.number_of_worker_nodes
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = "k8s"
  private_ip    = "172.31.0.2${count.index}"
  subnet_id = aws_subnet.subnet.id
  security_groups = [aws_security_group.sg.id, aws_default_security_group.default.id]
  source_dest_check = false

  tags = {
    Name  = "Worker-node-${count.index}"
  }
}