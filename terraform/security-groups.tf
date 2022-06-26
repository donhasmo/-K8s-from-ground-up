resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.kubernetes.id

  ingress {
    description      = "Ports for master nodes"
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = ["172.31.0.0/16"]
  }

  ingress {
    description      = "Ports for worker nodes"
    from_port        = 30000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Rule for API server"
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH Rule"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ICMP Rule"
    from_port        = 1
    to_port          = 1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Ports for kubelet and kube-proxy"
    from_port        = 10248
    to_port          = 10250
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "K8s-sg"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.kubernetes.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}