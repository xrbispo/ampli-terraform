resource "aws_security_group" "base-mgmt" {
  name        = "base-mgmt"
  description = "Base management allow rules"

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_remote_access
  }

  egress {
    description      = "Allow Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "base-mgmt"
  }
}

resource "aws_security_group" "base-web" {
  name        = "base-web"
  description = "Base webserver allow rules"

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_remote_access
  }

  ingress {
    description      = "Allow HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_remote_access
  }

  tags = {
    Name = "base-web"
  }
}
