provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "webserver01" {
  ami = var.amis["sa-east-1"]
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [ "${aws_security_group.base-mgmt.id}", "${aws_security_group.base-web.id}" ]
  user_data = "${file("userdata.sh")}"
  tags = {
    "Name" = "webserver01"
  }
}

resource "aws_s3_bucket" "xrbispo-s3-nginx" {
  bucket = "xrbispo-s3-nginx"

  tags = {
    Name = "xrbispo-s3-nginx"
  }
}
