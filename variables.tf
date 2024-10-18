# variable "access_key" {
#     description = "value of access"
# }

# variable "secret_key" {
#     description = "value of secret"   
# }

variable "instance_type" {
    default = "t3.small"
}

variable "ami_id" {
    default = "ami-005fc0f236362e99f"
}

variable "region" {
    default = "us-west-1"
}

variable "instance_name" {
    default = "valheim-server"
}

variable "key_name" {
    default = "ValheimKeyPair"
    type = string
}

variable "number_of_instances" {
    default = 1
    type = number
}

variable "password" {
    default = "password"
    type = string

}