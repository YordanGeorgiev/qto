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

// VPC Resource
resource "aws_vpc" "$ENV_TYPE-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}


// subnets
resource "aws_subnet" "$ENV_TYPE-subnet" {
  cidr_block = "${cidrsubnet(aws_vpc.$ENV_TYPE-vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.$ENV_TYPE-vpc.id}"
  availability_zone = "$availability_zone"
}


//security.tf
resource "aws_security_group" "$ENV_TYPE-sgr_qto_web" {
name = "$ENV_TYPE-sgr_qto_web"
vpc_id = "${aws_vpc.$ENV_TYPE-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


}


resource "aws_internet_gateway" "$ENV_TYPE-gw" {
	vpc_id = "${aws_vpc.$ENV_TYPE-vpc.id}"
}

resource "aws_route_table" "$ENV_TYPE-route-table" {
	vpc_id = "${aws_vpc.$ENV_TYPE-vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.$ENV_TYPE-gw.id}"
	}
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.$ENV_TYPE-subnet.id}"
  route_table_id = "${aws_route_table.$ENV_TYPE-route-table.id}"
}

resource "aws_key_pair" "$ENV_TYPE-aws_key_pair" {
  key_name   = "id_rsa.ysg.pub"
  public_key = "$public_key"
}

resource "aws_instance" "$ENV_TYPE-qto-inst" {
	ami           = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
  	subnet_id      = "${aws_subnet.$ENV_TYPE-subnet.id}"
   associate_public_ip_address = "true"
	security_groups = ["${aws_security_group.$ENV_TYPE-sgr_qto_web.id}"]
	key_name      = "id_rsa.ysg.pub"

  tags = {
    Name = "$ENV_TYPE-qto-ec2"
  }
}

resource "aws_eip" "$ENV_TYPE-ip-test" {
  instance = "${aws_instance.$ENV_TYPE-qto-inst.id}"
  vpc      = true
}
