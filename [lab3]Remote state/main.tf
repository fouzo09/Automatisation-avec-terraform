//REMOTE STATE

provider "aws" {
  region     = var.AWS_REGION
}

resource "aws_instance" "web" {
  ami               = var.INSTANCE_AMI
  instance_type     = var.INSTANCE_TYPE

  tags = {
    Name = var.INSTANCE_WEB_SERVER_NAME
  }
}

terraform {
  backend "s3" {
    bucket = "fouzterraformlab"
    key    = "states/terraform.state"
    region = "us-east-1"
  }
}
