output "internet_gateway" {
  value = var.has_igw ? aws_internet_gateway.igw : null
}

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

output "vpc_id" {
  value = aws_vpc.vpc.id
}