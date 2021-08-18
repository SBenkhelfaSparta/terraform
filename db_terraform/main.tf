# Let's build a script to connect to AWS and download/setup all dependencies required

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "db_instance" {

  key_name = "eng89_salem_ans"
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  subnet_id = "subnet-0419bfd3c3f016415"
  vpc_security_group_ids = ["${aws_security_group.db-ssh-allowed.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "eng89_salem_terraform_db"
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
      "sudo apt-get update -y",
      "sudo apt-get install -y dos2unix",
      "dos2unix ~/provision.sh",
      "chmod +x ~/provision.sh",
      "sudo ~/provision.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/eng89_salem_ans.pem")
      host        = self.public_ip
    }
  }

}
