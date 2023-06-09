data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/release_version"
}

resource "aws_eks_node_group" "worker_node_group" {
  cluster_name    = var.cluster_full_name
  #version         = aws_eks_cluster.example.version
  node_group_name = "${var.namespace}-worker-node-group"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 2
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
#resource "aws_autoscaling_group" "eks_node_asg" {
#  name                      = "${var.cluster_full_name}-workers-asg-${var.worker_instance_type}"
#  desired_capacity          = var.desired_worker_node_no
#
#  launch_template {
#    id = aws_launch_template.eks_node_launch_template.id
#    version = "$Latest"
#  }
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  max_size            = var.max_worker_node_no
#  min_size            = var.min_worker_node_no
#  vpc_zone_identifier = var.subnet_ids
#
#  tag {
#    key                 = "Name"
#    value               = "${var.namespace}-workers-${var.worker_instance_type}"
#    propagate_at_launch = true
#  }
#  
#  tag {
#    key                 = "kubernetes.io/cluster/${var.cluster_full_name}"
#    value               = "owned"
#    propagate_at_launch = true
#  }
#
#  #timeouts {
#  #  delete = "25m"
#  #}
#}
#
#resource "aws_launch_template" "eks_node_launch_template" {
#  name = "eks-node-launch-template"
#
#  block_device_mappings {
#    device_name = "/dev/sdf"
#
#    ebs {
#      volume_type = "gp2"
#      volume_size = 100 
#      delete_on_termination = true
#    }
#  }
#
#  iam_instance_profile {
#    arn = aws_iam_instance_profile.eks_worker_instance_profile.arn
#  }
#
#  image_id      = var.worker_ami_id
#  instance_type = var.worker_instance_type
#  key_name      = var.worker_key_name
#
#  lifecycle {
#    create_before_destroy = true 
#  }
#
#  monitoring {
#    enabled = true
#  }
#
#  #network_interfaces {
#  #  associate_public_ip_address = false
#  #  security_groups = ["${aws_security_group.workers_sg.id}"]
#  #}
#
#  vpc_security_group_ids = [aws_security_group.workers_sg.id]
#
#  tag_specifications {
#    resource_type = "instance"
#
#    tags = {
#      Name = "${var.namespace}-worker-node"
#    }
#  }
#
#  user_data = base64encode(data.template_file.worker_node_user_data_template.rendered)
#}