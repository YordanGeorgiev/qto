provider "aws" {
   access_key = "$access_key"
   secret_key = "$secret_key"
   region = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "environment_tag" {
  description = "Environment tag"
  default = "dev"
}

variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-east-2a"
}


variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/id_rsa.pub.ysg"
}

# VPC Resource
resource "aws_vpc" "vpc" {
  cidr_block = "10.11.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "10.11.0.0/16"
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_instance" "intra" {
	ami           = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
	subnet_id     = "${aws_subnet.subnet.id}"
   associate_public_ip_address = "true"

  tags = {
    Name = "intra"
  }
}

