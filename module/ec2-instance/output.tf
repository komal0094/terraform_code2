
# output "ec2-id" {
#   value = aws_instance.dev-ec2.id
# }
output "ec2-id" {
    value = {for k, v in aws_instance.dev-ec2: k => v.id}
  
}

