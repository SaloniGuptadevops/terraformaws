provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = "10.1.0.0/16"
  public_subnet_cidr = "10.1.1.0/24"
  environment        = "prod"
  region             = "ap-south-1"
}

module "security_group" {
  source      = "../../modules/security-group"
  environment = "prod"
  vpc_id      = module.vpc.vpc_id
}

module "ec2" {
  source            = "../../modules/ec2"
  ami_id            = "ami-07a00cf47dbbc844c"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
  environment       = "prod"
  key_name          = "my-key-pair"
}
