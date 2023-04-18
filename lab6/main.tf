provider "aws" {
    access_key = "AKIAY44W4NNGOZZYSRFQ"
    secret_key = "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"
    region = "us-east-1"
}

module "docker-install" {
    source = "./modules/docker-install"
}

module "docker-run" {
    source = "./modules/docker-run"
}