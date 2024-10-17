
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

resource "aws_instance" "valheim-server" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  key_name = "${var.key_name}"
  root_block_device {
    volume_size = 8
    delete_on_termination = true
  }
  security_groups = [aws_security_group.valheim_sg.name]
  
  
  tags = {
    Name = "${var.instance_name}"
  }
}