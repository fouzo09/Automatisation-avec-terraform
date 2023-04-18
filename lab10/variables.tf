variable "AWS_REGION" {
  type = string
  default = "us-east-1"
}

variable "ACCESS_KEY" {
    type = string
    default = "AKIAQ6TLVPOOMP3EVKZJ"
}

variable "SECRET_KEY" {
    type = string
    default = "zqaq2GoaYfjPV0a0PGXjH/pryec6u8DeN9Ho3lLV"
}

variable "INSTANCE_WEB_SERVER_NAME" {
  type = string
  default = "ec2-prod"
}

variable "INSTANCE_AMI" {
  type = string
  default = "ami-007855ac798b5175e"
}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"
}

variable "USER_DATA" {
  type = string
  default = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		sudo echo "<h1>Hello devopssec</h1>" > /var/www/html/index.html
	EOF
}

variable "SECURITY_GROUP_NAME" {
  type = string
  default = "terraform_sg"
}