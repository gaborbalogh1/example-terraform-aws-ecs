terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
  backend "s3" {
    bucket = var.tf_backend_bucket
    key    = "ecs/${var.service_name}/${var.environment}.tfstate"
    region = "eu-west-2"
  }
}

variable "service_name"     { type = string }
variable "environment"      { type = string }
variable "cpu"              { type = number, default = 256 }
variable "memory"           { type = number, default = 512 }
variable "desired_count"    { type = number, default = 1 }
variable "container_port"   { type = number, default = 3000 }
variable "tf_backend_bucket"{ type = string }

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.0"
  cluster_name = "${var.service_name}-${var.environment}"
}
