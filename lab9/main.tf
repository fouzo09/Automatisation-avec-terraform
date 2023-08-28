provider "aws" {
    region = "us-east-1"  
}

module "terraform_queue" {
    source = "./modules/sqs"  
}