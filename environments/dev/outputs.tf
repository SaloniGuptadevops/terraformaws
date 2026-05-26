output "dev_instance_ip" {
  value = module.ec2.public_ip
}

output "dev_vpc_id" {
  value = module.vpc.vpc_id
}
