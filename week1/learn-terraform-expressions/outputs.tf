output "private_addresses" {
  description = "Private DNS for AWS instances"
  value       = aws_instance.ubuntu[*].private_dns
}

output "private_addresses2" {
  description = "Private DNS for AWS instances"
  value       = aws_instance.ubuntu.*.private_dns
}
