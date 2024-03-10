resource "aws_security_group" "lb_sg" {
  name        = "allow_http_traffic"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.nfpoc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = [var.internet_cidr]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2_SG"
  description = "Allow HTTP inbound traffic from LB"
  vpc_id      = aws_vpc.nfpoc.id

  ingress {
    description      = "HTTP from LB"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    # cidr_blocks      = [var.internet_cidr]
    security_groups = [aws_security_group.lb_sg.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}