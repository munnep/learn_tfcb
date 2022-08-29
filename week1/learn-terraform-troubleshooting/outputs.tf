output "instance_id" {
  description = "ID of the EC2 instance"
  # value       = aws_instance.web_app[*].id
  value       = [for instance in aws_instance.web_app: instance.id]
}

output "instance_id2" {
  description = "ID of the EC2 instance"
  # value       = aws_instance.web_app[*].id
  value       = aws_instance.web_app
}

output "instance_id3" {
  description = "ID of the EC2 instance"
  # value       = aws_instance.web_app.*.id
  value       = aws_instance.web_app["sg_ping"].id
}


# output "instance_id2" {
#   description = "ID of the EC2 instance"
#   # value       = aws_instance.web_app.*.id
#   value       = [for i in aws_instance.web_app: i.id]
# }


# output "instance_public_ip" {
#   description = "Public IP address of the EC2 instance"
#   # value       = aws_instance.web_app.public_ip
#   value       = [for instance in aws_instance.web_app: instance.public_ip]
# }

# output "instance_name" {
#   description = "Tags of the EC2 instance"
#   # value       = aws_instance.web_app.tags
#   value        = [for instance in aws_instance.web_app: instance.tags.Name]
# }
