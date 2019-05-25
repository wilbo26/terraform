provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-05a36d3b9aa4a17ac"
  instance_type = "t2.micro"
  key_name      = "AWS_TF_XPS"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}
