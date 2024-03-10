
resource "aws_subnet" "nfpoc_public_subnet" {
  vpc_id = aws_vpc.nfpoc.id
  cidr_block = var.publicSubnet_cidr[count.index]
  #availability_zone = var.AZ[0]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  count = 2

   tags = {
    Name = "nfpoc_public_subnet.${count.index}"
  }
  
}

resource "aws_subnet" "nfpoc_private_subnet" {
  vpc_id = aws_vpc.nfpoc.id
  cidr_block = var.privateSubnet_cidr
  #availability_zone = var.AZ[1]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  count = 1

   tags = {
    Name = "nfpoc_private_subnet"
  }
}

  resource "aws_subnet" "nfpoc_protected_subnet" {
  vpc_id = aws_vpc.nfpoc.id
  cidr_block = var.protectedSubnet_cidr[count.index]
  #availability_zone = var.AZ[1]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  count = 2

   tags = {
    Name = "nfpoc_protected_subnet.${count.index}"
  }
  
}