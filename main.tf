# Let's build a script to connect to AWS and download/setup all dependencies required

provider "aws" {
  region = "eu-west-1"
}

# then run terraform init

# then launch aws services

# launch an ec2 instance

# keyword called "resource" provide resource name and give name with specific details to the service
resource "aws_instance" "app_instance" {

  key_name = "eng89_salem_ans"

  ami = "ami-038d7b856fe7557b3"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.prod-subnet-public-1.id

  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  associate_public_ip_address = true

  tags = {
    Name = "eng89_salem_terraform"
  }

  provisioner "file" {
    source      = "upload/"
    destination = "~/"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/eng89_salem_ans.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x provision.sh",
      "sudo ./provision.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/eng89_salem_ans.pem")
      host        = self.public_ip
    }
  }

}
