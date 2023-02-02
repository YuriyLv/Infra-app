terraform {
  required_version = ">= 1.1.0, <= 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.44.0"
    }
  }
}

variable "region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

