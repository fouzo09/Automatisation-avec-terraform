provider "aws" {
  region = "us-east-1"
}

module "nginx" {
  source = "./modules/nginx"
}