variable "amis" {
  type = map
  default = {
      "sa-east-1" = "ami-0c2485d67d416fc4f"
  }
}

variable "cdirs_remote_access" {
  type = list
  default = ["191.193.187.106/32"]
}

variable "key_name" {
  type = string
  default = "terraform-aws"
}
