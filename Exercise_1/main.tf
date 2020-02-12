terraform {
  required_version = ">= 0.12.0"
}
# TODO: Designate a cloud provider, region, and credentials

# default values of VARS are populated by .env value, forwarded by docker-compose
variable "region" {}
# reference to Cloud credentials
variable "aws_profile" {}
provider "aws" {
    version = ">= 2.48"
    # access_key = "${var.AWS_ACCESS_KEY}"
    # secret_key = "${var.AWS_SECRET_KEY}"
    profile= var.aws_profile
    # path in container (Check docker-compose file)
    shared_credentials_file = "/root/.aws/credentials"
    region  = var.region
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

locals {
  ami_amz_linux2 = "ami-062f7200baf2fa504"
  subnet_id = "subnet-8c896aeb"
}

resource "aws_instance" "udacity_t2" {
  count = 4
  ami           = local.ami_amz_linux2
  subnet_id     = local.subnet_id

  instance_type = "t2.micro"
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "udacity_m4" {
  count = 2
  ami           = local.ami_amz_linux2
  instance_type = "m4.large"
  tags = {
    Name = "Udacity M4"
  }
}

