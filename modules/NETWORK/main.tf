/*_________VPC _________*/
resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}

/*_________SUBNETS_________*/
resource "aws_subnet" "subnet" {
  for_each = var.subnets

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]  # Use the availability zone specified in the variable

  tags = {
    Name = each.key
  }

  map_public_ip_on_launch = each.value["public"] ? true : false
}


/*_________Routetables_________*/
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = var.public_route_name
  }
}
resource "aws_route" "igw-route" {
  route_table_id            = aws_route_table.public-route.id
  destination_cidr_block    = var.cidr_from_anywhere
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "first" {
  subnet_id      = aws_subnet.subnet["public_subnet1"].id  
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "second" {
  subnet_id      = aws_subnet.subnet["public_subnet2"].id  
  route_table_id = aws_route_table.public-route.id
}


resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = var.private_route_name
  }

}
resource "aws_route" "natgw-route" {
  route_table_id            = aws_route_table.private-route.id
  destination_cidr_block    = var.cidr_from_anywhere
  gateway_id = aws_nat_gateway.nat-gw.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet["private_subnet_1"].id
  route_table_id = aws_route_table.private-route.id
}

/*_______internetgateway_______natgateway_______*/
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}
/*_________________________________________________*/
resource "aws_eip" "eip" {
    domain = "vpc"
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet["public_subnet1"].id 

  tags = {
    Name = var.natgateway_name
  }

  depends_on = [aws_internet_gateway.igw]
}
/*_________security_groups_________*/
resource "aws_security_group" "secgroup" {
  description = var.security_group_description
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = var.security_group_name
  }

  # ingress {
  #   from_port   = var.inport
  #   to_port     = var.inport
  #   protocol    = var.tcp_protocol
  #   cidr_blocks = [var.cidr_from_anywhere]
  # }

  # ingress {
  #   from_port   = var.ssh_port
  #   to_port     = var.ssh_port
  #   protocol    = var.tcp_protocol
  #   cidr_blocks = [var.cidr_from_anywhere]
  # }

  # egress {
  #   from_port   = var.eg_port
  #   to_port     = var.eg_port
  #   protocol    = var.eg_protocol 
  #   cidr_blocks = [var.cidr_from_anywhere]
  # }
}

resource "aws_security_group_rule" "ingress" {
  type      = "ingress"
  for_each  = toset(var.inport)
  from_port = each.value
  to_port   = each.value
  protocol  = var.in_protocol
  cidr_blocks = [var.cidr_from_anywhere]
  security_group_id = aws_security_group.secgroup.id
}
resource "aws_security_group_rule" "egress" {
  type      = "egress"
  from_port = var.eg_port
  to_port   = var.eg_port
  protocol  = var.eg_protocol
  cidr_blocks = [var.cidr_from_anywhere]
  security_group_id = aws_security_group.secgroup.id
}


