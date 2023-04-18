//LES MODULES AVEC TERRAFORM

provider "aws" {
    region = "us-east-1"
}

module "docker-install" {
    source = "./modules/docker-install"
}

module "docker-run" {
    source = "./modules/docker-run"
}