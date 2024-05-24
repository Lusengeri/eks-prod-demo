output "cluster_ca" {
  value = module.control_plane.cluster_ca
}

output "cluster_endpoint" {
  value = module.control_plane.cluster_endpoint
}

output "eks_cluster_iam_role" {
  value = module.control_plane.eks_cluster_iam_role
}

output "cluster_identity_oidc_issuer" {
  value = module.control_plane.cluster_identity_oidc_issuer
}

output "cluster_full_name" {
  value = module.control_plane.cluster_full_name
}

output "cluster_id" {
  value = module.control_plane.cluster_id
}

output "workers_iam_role" {
  value = module.workers.workers_iam_role
}