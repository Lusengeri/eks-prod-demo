resource "aws_security_group" "control_plane_sg" {
  name        = "${var.namespace}-${var.stage}-cluster-control-plane-security-group"
  description = "security group for for the ${var.namespace}-${var.stage}-cluster control plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                        = "${var.namespace}-${var.stage}-cluster-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "masters_api_ingress" {
  description       = "Allow cluster control plane to receive communication from workers kubelets and pods"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.control_plane_sg.id
  #source_security_group_id = var.workers_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  to_port     = 443
  type        = "ingress"
}