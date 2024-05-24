output "cluster_ca" {
  value = aws_eks_cluster.app_cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
  value = aws_eks_cluster.app_cluster.endpoint
}

output "eks_cluster_iam_role" {
  value = aws_iam_role.eks_cluster_iam_role
}

output "cluster_id" {
  value = aws_eks_cluster.app_cluster.cluster_id
}

output "cluster_identity_oidc_issuer" {
  value = aws_eks_cluster.app_cluster.identity.0.oidc.0.issuer 
}

output "cluster_full_name" {
  value = aws_eks_cluster.app_cluster.name
}

output "control_plane_sg_id" {
  value = aws_security_group.control_plane_sg.id
}

output "cluster_version" {
  value = aws_eks_cluster.app_cluster.version
}

output "endpoint" {
  value = aws_eks_cluster.app_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.app_cluster.certificate_authority[0].data
}