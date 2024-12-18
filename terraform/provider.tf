terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        }
    }

    backend "s3" {
        bucket = "terraform-state-khoahoang"
        key    = "terraform_state"
        region = "us-east-1"
    }
}
provider "aws" {
    region = var.region
    #access_key = "${var.access_key}"
    #secret_key = "${var.secret_key}"
}       
