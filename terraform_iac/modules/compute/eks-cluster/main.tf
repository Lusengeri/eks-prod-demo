module "control_plane" {
  source = "../eks-control-plane"

  cluster_name       = var.cluster_name
  stage        = var.stage
  kubernetes_version = var.kubernetes_version
  namespace          = var.namespace
  subnet_ids         = concat(var.public_subnet_ids, var.private_subnets_ids)
  vpc_id             = var.vpc_id
  workers_sg_id      = module.workers.workers_sg_id
}

module "workers" {
  source = "../eks-workers"

  cluster_ca                      = module.control_plane.cluster_ca
  cluster_endpoint                = module.control_plane.cluster_endpoint
  cluster_full_name               = module.control_plane.cluster_full_name
  cluster_version                 = module.control_plane.cluster_version
  control_plane_security_group_id = module.control_plane.control_plane_sg_id
  desired_worker_node_no          = var.desired_worker_node_no
  stage                     = var.stage
  max_worker_node_no              = var.max_worker_node_no
  min_worker_node_no              = var.min_worker_node_no
  namespace                       = var.namespace
  subnet_ids                      = var.private_subnets_ids
  vpc_id                          = var.vpc_id
  worker_ami_id                   = var.worker_ami_id
  worker_instance_type            = var.worker_instance_type
}