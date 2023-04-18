//SE CONNECTER A AWS ET CREER UNE INSTANCE AWS

provider "aws" {
  region = "us-east-1"
  access_key = "AKIA22RC3YCYOV3CHDQS"
  secret_key = "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"
}

resource "aws_instance" "server_jenkins" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins Server"
  }
}

