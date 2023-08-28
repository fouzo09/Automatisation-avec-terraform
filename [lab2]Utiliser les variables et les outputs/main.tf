//LES VARIABLES ET LES OUTPUTS

provider "aws" {
  region     = var.AWS_REGION
}

resource "aws_instance" "web" {
  ami           = var.INSTANCE_AMI
  instance_type = var.INSTANCE_TYPE

  tags = {
    Name = var.INSTANCE_WEB_SERVER_NAME
  }
}
