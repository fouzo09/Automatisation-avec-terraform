
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
    source = "../modules/vpc"
    cidr_block = "192.168.0.0/16"   
    instance_tenancy = "default"
    vpc_id = "${module.vpc.vpc_id}" 
    subnet_cidr = "192.168.1.0/24"
}

module "ec2" {
    source = "../modules/ec2"
    subnet_id = "${module.vpc.subnet_id}"
}