output "instance_ip_addr_private" {
  value = module.ec2_instance.private_ip
}

output "instance_ip_addr_public" {
  value = module.ec2_instance_public.private_ip
}

output "security_group_id" {
  value = module.server-sg.security_group_id
}