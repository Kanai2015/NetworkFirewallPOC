
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# data "aws_vpc_endpoint"  "AWS_NFW" {

#   vpc_id = aws_vpc.nfpoc.id
#   state = "available"

#   tags = {
#     Firewall                  = aws_networkfirewall_firewall.networkfirewall2.arn
#     AWSNetworkFirewallManaged = "true"
#   }

# }

# locals {
#   key = join(",",data.aws_vpc_endpoint.AWS_NFW.network_interface_ids)
# }

# data "aws_network_interface" "ENI_0" {
#   id = local.key
# }