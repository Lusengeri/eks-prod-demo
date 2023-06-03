resource "aws_security_group" "control_plane_sg" {
  name        = "${var.namespace}-cluster-control-plane-security-group"
  description = "security group for for the ${var.namespace}-cluster control plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                                 = "${var.namespace}-cluster-sg"
    "kubernetes.io/cluster/${var.namespace}-eks-cluster" = "owned"
  }
  #  tags = merge(
  #    var.common_tags,
  #    {
  #      Name                                             = "${var.cluster_full_name}-cluster-sg"
  #      "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
  #    },
  #  )
}

resource "aws_security_group_rule" "masters_api_ingress" {
  description              = "Allow cluster control plane to receive communication from workers kubelets and pods"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.control_plane_sg.id
  source_security_group_id = var.workers_sg_id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "masters_kubelet_egress" {
  description              = "Allow the cluster control plane to reach out workers kubelets and pods"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.control_plane_sg.id
  source_security_group_id = var.workers_sg_id
  type                     = "egress"
}

resource "aws_security_group_rule" "masters_kubelet_https_egress" {
  description              = "Allow the cluster control plane to reach out workers kubelets and pods https"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.control_plane_sg.id
  source_security_group_id = var.workers_sg_id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "masters_workers_egress" {
  description              = "Allow the cluster control plane to reach out all worker node security group"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.workers_sg_id
  type                     = "egress"
}