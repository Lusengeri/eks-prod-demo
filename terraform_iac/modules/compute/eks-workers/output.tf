output "workers_iam_role" {
  value = aws_iam_role.eks_worker_role 
}

output workers_sg_id {
  value = aws_security_group.workers_sg.id
}