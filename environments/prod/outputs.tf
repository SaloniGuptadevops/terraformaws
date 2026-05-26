output "prod_instance_ip" {
  value = module.ec2.public_ip
}

output "prod_vpc_id" {
  value = module.vpc.vpc_id
}
