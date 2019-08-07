provider "aws" {
  region     = var.region
}
resource "aws_instance" "example" {

  ami           = "ami-05a36d3b9aa4a17ac"
  instance_type = "t2.micro"
  key_name      = "AWS_XPS_LIN"

  provisioner "remote-exec" {
    inline = [
                "sudo apt install ansible -y",
                "sudo apt install htop -y",
                "sudo apt install iotop -y"
             ]

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

#TODO: Add local-exec to run local playbook against the new host once ansible is installed remotely
#TODO: Not sure how this will work, but seems reasonable. 
#TODO: https://alex.dzyoba.com/blog/terraform-ansible/ for reference. 
