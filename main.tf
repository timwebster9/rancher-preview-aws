provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "rancher-preview-vpc"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.main.id}"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP from anywhere
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.medium"
  key_name      = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = ["${aws_default_security_group.default.id}"]
  
  tags {
    Name = "rancher-preview"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "rancher-preview-pk"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiKQkNQFD5/3E9nlePguEItW48ZjO5r+u0S7hIQJPwUgGzXlJ2YNCNcXKtTvy1xQHQ6K9UaJ82fYS6szW+ZIteLc8XA/g7fiUhpiGikxCaMmaRdCGn11hX2AAAUg5G04jXLqNVBLUVHK552s4FjE2NI5X/lcyZwAoyQl2yFFpVkKgOAjkQHf9uUeuQgj1VOyicNBjIhdNMrAhApMavKzZ9163UeEYdqrTQQdok1GqDNguGLnbp4GcHIkQz8ysNUG3AhxFjh2nj5yfjp3JLK7PuqAza0RffiYxlVqHiAvAPmWzQhgEWS0gXsQu9zydptlCp5WvCLnwsYp402nH6ioKP timw@L-156095607.local"
}
