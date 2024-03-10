# resource "aws_nat_gateway" "nfpoc_natgw" {
#   allocation_id = aws_eip.nfpoc_eip.id
#   subnet_id = aws_subnet.nfpoc_protected_subnet[count.index].id
#   count=1
#   tags = {
#     Name = "nfpoc_natgw"
#   }
# }