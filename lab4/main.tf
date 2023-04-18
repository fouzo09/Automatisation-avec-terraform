//REMOTE STATE

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
}

resource "aws_instance" "web" {
  ami               = var.INSTANCE_AMI
  instance_type     = var.INSTANCE_TYPE
  vpc_security_group_ids = [ aws_security_group.instance_sg.id ]

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
