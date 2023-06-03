resource "aws_autoscaling_group" "eks_node_asg" {
  name                      = "eks-node-autoscaling-group"
  desired_capacity          = var.desired_worker_node_no
  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id = aws_launch_template.eks_node_launch_template.id
  }

  lifecycle {
    create_before_destroy = true
  }

  max_size            = var.max_worker_node_no
  min_size            = var.min_worker_node_no
  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "Name"
    value               = "${var.namespace}-eks-autoscaling-group"
    propagate_at_launch = true
  }

  timeouts {
    delete = "25m"
  }
}

resource "aws_launch_template" "eks_node_launch_template" {
  name = "eks-node-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_type = "gp3"
      volume_size = 20
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.eks_worker_instance_profile.arn
  }

  image_id      = var.worker_image_id
  instance_type = var.worker_instance_type
  key_name      = var.worker_key_name

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  vpc_security_group_ids = [aws_security_group.workers_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.namespace}-worker-node"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}