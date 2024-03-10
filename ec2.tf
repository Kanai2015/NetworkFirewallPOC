
resource "aws_instance" "nfpoc_instance" {
    # ami = data.aws_ami.app_ami.id
    ami = var.AMI_ID
    instance_type = var.instanceType
    subnet_id = aws_subnet.nfpoc_private_subnet[count.index].id
    security_groups = [aws_security_group.ec2_sg.id]
    count=1

    # user_data = <<EOF
    # #!/bin/bash
    # sudo yum install -y httpd
    # sudo systemctl start httpd.service
    # sudo systemctl enable httpd.service
    # echo 'Started Apache from Terraform 2nd server' > /var/www/html/index.html
    # EOF

    tags = {
        Name = "nfpoc_apacheserver"
    }
}














