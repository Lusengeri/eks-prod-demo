resource "aws_eks_node_group" "worker_node_group" {
  cluster_name    = var.cluster_full_name
  version         = var.cluster_version
  instance_types  = [var.worker_instance_type]
  node_group_name = "${var.namespace}-${var.stage}-worker-node-group"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  release_version = var.ami_release_version
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_worker_node_no
    max_size     = var.max_worker_node_no
    min_size     = var.min_worker_node_no
  }

  tags = {
    "stage"                                          = var.stage
    "Name"                                           = "${var.namespace}-worker-node-group"
    "kubernetes.io/cluster/${var.cluster_full_name}" = "owned"
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}