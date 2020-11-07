provider "aws" {
  version = "2.23.0"
  region  = "ap-northeast-1"

}

terraform {
  required_version = "0.12.6"
  backend "s3" {
    bucket = "ft-state-mst"
    key    = "sample_ec2/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "ec2" {
  source          = "./modules/ec2"
  public_subnet = module.vpc.sample-subnet-1a
  security_group          = module.security_group.web_sg
  key_name        = "sample-terraform"
  public_key      = "sample-terraform.pub"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source     = "./modules/security_group"
  sample-vpc = module.vpc.sample-vpc
}

module "iam" {
  source = "./modules/iam"
}

module "rds" {
  source            = "./modules/rds"
  private_subnet_1a = module.vpc.sample-private-subnet-1a
  private_subnet_1c = module.vpc.sample-private-subnet-1c
  security_group    = module.security_group.db_sg
}

module "alb" {
  source          = "./modules/alb"
  security_groups = [module.security_group.alb_sg.id]
  subnets = [
    module.vpc.sample-subnet-1a.id,
    module.vpc.sample-subnet-1c.id
  ]
  vpc_id    = module.vpc.sample-vpc.id
  target_id = module.ec2.sample-ec2.id
}
