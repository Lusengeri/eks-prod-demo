output "sgs" {
  value = {
    alb_sg     = aws_security_group.alb_sg.id
    cluster_sg = aws_security_group.cluster_sg.id
  }
}

output "subnets" {
  value = {
    database_subnets = aws_subnet.database_subnet_
    private_subnets  = aws_subnet.private_subnet_
    public_subnets   = aws_subnet.public_subnet_
  }
}