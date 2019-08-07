variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-05a36d3b9aa4a17ac"
    "us-west-2" = "ami-4b32be2b"
  }
}

output "ip" {
  value = aws_eip.ip.public_ip
}

variable "ssh_key_private" {}
