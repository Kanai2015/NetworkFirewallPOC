resource "aws_internet_gateway" "nfpoc_igw" {
  vpc_id = aws_vpc.nfpoc.id

  tags = {
    Name = "nfpoc_igw"
  }
}