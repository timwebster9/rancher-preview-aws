
variable "region" {
    default = "us-east-1"
}

variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-east-1 = "ami-66506c1c"
  }
}

variable "instance_type" {
  description = "Instance type to launch with"
  default = {
    us-east-1 = "t2.medium"
  }
}
variable "vpc_cidr" {
  description = "VPC CIDR block range"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR block range"
  default = "10.0.0.0/24"
}

