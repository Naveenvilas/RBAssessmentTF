provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
}
