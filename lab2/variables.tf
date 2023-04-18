variable "AWS_REGION" {
  type = string
  default = "us-east-1"
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

variable "SECURITY_GROUP_NAME" {
  type = string
  default = "terraform_sg"
}