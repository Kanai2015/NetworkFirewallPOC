resource "aws_route_table" "nfpoc_public_RT" {
  vpc_id = aws_vpc.nfpoc.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.nfpoc_igw.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }


  tags = {
    Name = "nfpoc_public_RT"
  }
}

resource "aws_route_table" "nfpoc_protected_RT" {
  vpc_id = aws_vpc.nfpoc.id
  route {
    
    cidr_block = var.internet_cidr
    vpc_endpoint_id = local.vpc_endpoints[count.index].endpoint_id
   }
  count=2

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }


  tags = {
    Name = "nfpoc_protected_RT.${count.index}"
    # Name = "nfpoc_protected_RT"
  }
}


resource "aws_route_table" "nfpoc_private_RT" {
  vpc_id = aws_vpc.nfpoc.id


  # route {
  #   cidr_block = var.internet_cidr
  #   nat_gateway_id = element(aws_nat_gateway.nfpoc_natgw[*].id,0)
 
  # }

   route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }


  tags = {
    Name = "nfpoc_private_RT"
  }
}

#create internet gateway ingress route table
resource "aws_route_table" "nfpoc_IGIngress_RT" {
  vpc_id = aws_vpc.nfpoc.id
   
  dynamic route {
    for_each = zipmap(var.protectedSubnet_cidr[*],local.vpc_endpoints[*].endpoint_id)

    content {
      cidr_block = route.key
      vpc_endpoint_id = route.value
    }
  }
  

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "nfpoc_IGIngress_RT"
  }
}

resource "aws_route_table_association" "IGIngress_association" {
  
  gateway_id = aws_internet_gateway.nfpoc_igw.id
  route_table_id = aws_route_table.nfpoc_IGIngress_RT.id
  # count=1
  
}

resource "aws_route_table_association" "private_RT_subnet" {
  subnet_id = aws_subnet.nfpoc_private_subnet[count.index].id
  route_table_id = aws_route_table.nfpoc_private_RT.id
  count=1
  
}

resource "aws_route_table_association" "public_RT_subnet" {
  subnet_id = aws_subnet.nfpoc_public_subnet[count.index].id 
  count = 2
  route_table_id = aws_route_table.nfpoc_public_RT.id
  
}

resource "aws_route_table_association" "protected_RT_subnet" {
  subnet_id = aws_subnet.nfpoc_protected_subnet[count.index].id 
  count = 2
  route_table_id = aws_route_table.nfpoc_protected_RT[count.index].id
  # route_table_id = aws_route_table.nfpoc_protected_RT.id

  
}