variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "publicSubnet_cidr" {
  type = list(string)
  default = ["10.0.10.0/24", "10.0.40.0/24"]
}

variable "protectedSubnet_cidr" {
  type = list(string)
  default = ["10.0.10.0/24", "10.0.40.0/24"]
}

variable "privateSubnet_cidr" {
  type = string
  default ="10.0.20.0/24"
}

variable "internet_cidr" {
  type = string
  default ="0.0.0.0/0"
}

variable "instanceType" {
  type = string
  default = "t2.micro"
}

variable "AMI_ID" {
  type = string
  default = "ami-03bc03e3a68a7f5f7"
  
}

variable "AZ" {
  type = list 
  default = ["eu-central-1a","eu-central-1b","eu-central-1c"]
  
}

variable "port" {
  type = string
  default = "80"  
}