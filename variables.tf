variable "access_key" {
    description = "value of access"
}

variable "secret_key" {
    description = "value of secret"   
}

variable "instance_type" {
    default = "t3.small"
}

variable "ami_id" {
    default = "ami-005fc0f236362e99f"
}

variable "region" {
    default = "us-west-2"
}

variable "instance_name" {
    default = "valheim-server"
}