output "instance_ip_addr_private" {
  value = module.ec2_instance_rhel.private_ip
}

output "security_group_id" {
  value = module.server-sg.security_group_id
}
