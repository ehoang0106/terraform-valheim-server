variable "access_key" {
    description = "value of access"
}

variable "secret_key" {
    description = "value of secret"   
}

variable "instance_type" {
    default = "t3.medium"
}

variable "ami_id" {
    default = "ami-0da424eb883458071"
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
