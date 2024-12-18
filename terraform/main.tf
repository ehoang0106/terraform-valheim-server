
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
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.valheim_sg.id]
    root_block_device {
    volume_size = 10
    delete_on_termination = true
    }

    user_data = base64encode(data.template_file.user_data.rendered)

    tags = {
        Name = "valheim-server"
    }

}

resource "aws_cloudwatch_metric_alarm" "valheim-network-in-alarm" {
    alarm_name                = "vrisng-network-in-alarm"
    comparison_operator       = "LessThanOrEqualToThreshold"
    evaluation_periods        = 2
    metric_name               = "NetworkPacketsIn"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 300
    alarm_description         = "Monitor network packets in"
    dimensions = {
        InstanceId = resource.aws_instance.valheim-instance.id
    }
    actions_enabled     = "true"
    alarm_actions       = ["arn:aws:automate:us-west-1:ec2:stop"]
}
