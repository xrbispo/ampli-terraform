output "Webserver01_public_ip" {
  description = "Webserver Public IP"
  value       = aws_instance.webserver01.public_ip
}
