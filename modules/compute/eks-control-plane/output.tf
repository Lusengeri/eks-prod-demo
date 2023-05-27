output "endpoint" {
  value = aws_eks_cluster.app_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.app_cluster.certificate_authority[0].data
}