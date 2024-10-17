
resource "aws_security_group" "valheim_sg" {
  name = "valheim_sg"
  
  ingress {
    description = "valheim port allow udp"
    from_port = 2456
    to_port = 2458
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "valheim port allow tcp"
    from_port = 2456
    to_port = 2458
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "ssh port allow"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound-rule"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        }
    }
}
provider "aws" {
    region = "us-west-2"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}       

resource "aws_instance" "valheim-server" {
    ami = var.ami_id
    count = var.number_of_instances
    instance_type = var.instance_type
    tags = {
        Name = "valheim-server"
    }
}
