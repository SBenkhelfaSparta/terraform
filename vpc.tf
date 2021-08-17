resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.208.0.0/16"
    instance_tenancy = "default"    
    
    tags = {
        Name = "eng89_salem_vpc"
    }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = aws_vpc.prod-vpc.id
    cidr_block = "10.208.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-west-1a"
    tags = {
        Name = "eng89_salem_subnet_public"
    }
}