output "cluster_ca" {
  value = aws_eks_cluster.app_cluster.certificate_authority[0].data
}

output "control_plane_sg_id" {
  value = aws_security_group.control_plane_sg.id
}

output "endpoint" {
  value = aws_eks_cluster.app_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.app_cluster.certificate_authority[0].data
}