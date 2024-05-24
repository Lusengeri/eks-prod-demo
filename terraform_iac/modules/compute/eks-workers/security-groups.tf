resource "aws_security_group" "workers_sg" {
  name        = "${var.namespace}-${var.environment}-workers"
  description = "Security group for all nodes in the ${var.namespace}-${var.environment} cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                             = "${var.namespace}-cluster-sg"
    "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker_to_worker_tcp" {
  description              = "Allow workers tcp communication with each other"
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.workers_sg.id
  source_security_group_id = aws_security_group.workers_sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_to_worker_udp" {
  description              = "Allow workers udp communication with each other"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "udp"
  security_group_id        = aws_security_group.workers_sg.id
  source_security_group_id = aws_security_group.workers_sg.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "workers_masters_ingress" {
  description              = "Allow workers kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.workers_sg.id
  source_security_group_id = var.control_plane_security_group_id
  type                     = "ingress"
}

resource "aws_security_group_rule" "workers_masters_https_ingress" {
  description              = "Allow workers kubelets and pods to receive https from the cluster control plane"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.workers_sg.id
  source_security_group_id = var.control_plane_security_group_id
  type                     = "ingress"
}