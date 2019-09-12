provider "aws" {
   access_key = "$access_key"
   secret_key = "$secret_key"
   region = "$aws_region"
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
  default = "$availability_zone"
}


variable "public_key_path" {
  description = "Public key path"
  default = "$ssh_key_pair_file"
}

# VPC Resource
resource "aws_vpc" "vpc-$ENV_TYPE" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.qto-$ENV_TYPE.id}"
  vpc      = true
}

# subnets.tf
resource "aws_subnet" "subnet-$ENV_TYPE" {
  cidr_block = "${cidrsubnet(aws_vpc.vpc-$ENV_TYPE.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.vpc-$ENV_TYPE.id}"
  availability_zone = "$availability_zone"
}


//security.tf
resource "aws_security_group" "ingress-all-test" {
name = "allow-all-sg"
vpc_id = "${aws_vpc.vpc-$ENV_TYPE.id}"
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


//internet gateway
resource "aws_internet_gateway" "gw-$ENV_TYPE" {
	vpc_id = "${aws_vpc.vpc-$ENV_TYPE.id}"
}

resource "aws_route_table" "route-table-$ENV_TYPE" {
	vpc_id = "${aws_vpc.vpc-$ENV_TYPE.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.gw-$ENV_TYPE.id}"
	}
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-$ENV_TYPE.id}"
  route_table_id = "${aws_route_table.route-table-$ENV_TYPE.id}"
}

resource "aws_key_pair" "aws_key_pair-$ENV_TYPE" {
  key_name   = "id_rsa.ysg.pub"
  public_key = "$public_key"
}

resource "aws_instance" "qto-$ENV_TYPE" {
	ami           = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
  	subnet_id      = "${aws_subnet.subnet-$ENV_TYPE.id}"
   associate_public_ip_address = "true"
   //id of the security group which has ports open to all the IPs
	security_groups = ["${aws_security_group.ingress-all-test.id}"]
	key_name      = "id_rsa.ysg.pub"

  tags = {
    Name = "qto-ec2-$ENV_TYPE"
  }
}

