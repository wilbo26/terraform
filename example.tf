provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
resource "aws_instance" "example" {

  ami           = "ami-05a36d3b9aa4a17ac"
  instance_type = "t2.micro"
  key_name      = "AWS_XPS_LIN"

  provisioner "remote-exec" {
    inline = ["sudo apt install ansible -y"]

    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ssh_key_private)}"
    }
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}