output "aws_instance" {
  value = aws_instance.my-instace[*].public_ip
}