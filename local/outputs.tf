# output "ec2-public-ip" {
#   value = aws_instance.from_terraform[*].public_ip
# }

# output "ec2-public-dns" {
#   value = aws_instance.from_terraform[*].public_dns
# }

output "ec2-public-ip" {
  value = [for instance in aws_instance.from_terraform : instance.public_ip]
}

output "ec2-public-dns" {
  value = [for instance in aws_instance.from_terraform : instance.public_dns]
}