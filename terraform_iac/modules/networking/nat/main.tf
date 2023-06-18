resource "aws_eip" "nat_gw_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_ip.id
  subnet_id     = var.nat_subnet_id

  tags = {
    Name = "${var.namespace}-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gateway]
}

resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.namespace}-private-route-table"
  }
}

resource "aws_route_table_association" "route_table_assoc_private_subnet_" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_route" "route_to_nat_gw" {
  route_table_id         = aws_route_table.private_subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}