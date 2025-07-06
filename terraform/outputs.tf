output "frontend_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.frontend_server.id
}

output "frontend_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.frontend_server.public_ip
}

output "bankend_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.backend_server.id
}

output "bastion_instance_id" {
  description = "ID of the Bastion instance"
  value       = aws_instance.bastion_server.id
}
