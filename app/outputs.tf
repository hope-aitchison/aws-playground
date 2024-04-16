output "instance_ip_addr" {
  value = module.ec2_instance.private_ip
}

output "security_group_id" {
  value = module.server-sg.security_group_id
}