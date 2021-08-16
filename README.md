### Terraform
## Getting started
After installing Terraform onto your machine, create a new folder where you will be creating a `main.tf` file. In the file write down this code:
```
provider "aws" {
	region = "eu-west-1"
}

resource "aws_instance" "app_instance"{

	key_name = "your_key" # Has to be in your .ssh folder
	ami = "ami-038d7b856fe7557b3"
	instance_type = "t2.micro"
	associate_public_ip_address = true

	tags = {
		Name = "name_of_instance"
	}
}
```

If you don't already have your AWS keys saved in your environment variables, do so by naming them `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
Open up terminal/cmd in the folder and run `terraform plan`. If that was successful run `terraform apply` to create the instance.