
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
    region = var.region
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}       

resource "aws_instance" "valheim-server" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.valheim_sg.id]
    root_block_device {
    volume_size = 8
    delete_on_termination = true
  }
    tags = {
        Name = "valheim-server"
    }

    user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo snap install docker
    sudo addgroup --system docker
    sudo adduser ubuntu docker
    newgrp docker
    sudo snap disable docker
    sudo snap enable docker

    mkdir -p /home/ubuntu/valheim/saves
    mkdir -p /home/ubuntu/valheim/server

    docker run -d --name="valheim" \
    --net='bridge' \
    --restart=unless-stopped \
    -e PORT=2456 \
    -e NAME="lazyValheim" \
    -e WORLD="lazyValheim" \
    -e TZ="Australia/Melbourne" \
    -e PASSWORD="Valheim24" \
    -e PUBLIC=1 \
    -p 2456:2456/udp \
    -p 2457:2457/udp \
    -p 2458:2458/udp \
    -v ./valheim/saves:/home/steam/.config/unity3d/IronGate/Valheim \
    -v ./valheim/server:/home/steam/valheim \
    'mbround18/valheim:latest'
    EOF
}
