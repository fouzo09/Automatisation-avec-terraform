//LES VARIABLES ET LES OUTPUTS

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_KEY
}

resource "aws_key_pair" "my_ec2" {
    key_name   = "terraform-key"
    public_key = file("./terraform.pub")
}

resource "aws_instance" "web" {
  key_name      = aws_key_pair.my_ec2.key_name
  ami           = var.INSTANCE_AMI
  instance_type = var.INSTANCE_TYPE
  user_data     = var.USER_DATA

  tags = {
    Name = var.INSTANCE_WEB_SERVER_NAME
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.myip.id
}
