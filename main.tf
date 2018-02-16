provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.medium"
  key_name      = "timw-mac"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  
  tags {
    Name = "rancher-preview"
  }
}

resource "aws_security_group" "instance" {
  name = "rancher-preview-sc"

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
}


