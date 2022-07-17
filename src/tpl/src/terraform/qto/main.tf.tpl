provider "aws" {
   access_key = "$AWS_ACCESS_KEY_ID"
   secret_key = "$AWS_SECRET_ACCESS_KEY"
   region = "$AWS_DEFAULT_REGION"
   profile = "{{ aws['AWS_PROFILE'] }}"
}

// the ubuntu-bionic-18.04 base ami image is used
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
  default = "{{ ENV }}"
}

variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "{{ aws['availability_zone'] }}"
} 

variable "public_key_path" {
  description = "Public key path"
  default = "$public_ssh_key_fpath"
}

// VPC Resource
resource "aws_vpc" "vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
   Name = "vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}"
   Version = "{{ VERSION }}"
  }
}


// subnets
resource "aws_subnet" "subnet_{{ PROJ }}_{{ ENV }}_{{ VER }}" {
  cidr_block = "${cidrsubnet(aws_vpc.vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}.cidr_block, 3, 1)}"
   vpc_id = "${aws_vpc.vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"
   availability_zone = "{{ aws['availability_zone'] }}"

  tags = {
   Name = "subnet_{{ PROJ }}_{{ ENV }}_{{ VER }}"
   Version = "{{ VER }}"
  }
}


resource "aws_security_group" "{{ ENV }}_{{ VER }}_sgr_qto_web" {
name = "{{ ENV }}_{{ VER }}_sgr_qto_web"
vpc_id = "${aws_vpc.vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"

  // morbo dev
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // morbo tst
  ingress {
    from_port   = 3002
    to_port     = 3002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // morbo prd
  ingress {
    from_port   = 3003
    to_port     = 3003
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // hypnotoad dev
  ingress {
    from_port   = 8078
    to_port     = 8078
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // hypnotoad tst
  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // hypnotoad prd
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ngix dev
  ingress {
    from_port   = 78
    to_port     = 78
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ngix tst
  ingress {
    from_port   = 82
    to_port     = 82
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ngix prd
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // https nginx dev
  ingress {
    from_port   = 441
    to_port     = 441
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // https nginx tst
  ingress {
    from_port   = 442
    to_port     = 442
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // https nginx prd
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  // postgres
  ingress {
    from_port   = 15432 
    to_port     = 15432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


}



resource "aws_internet_gateway" "{{ ENV }}_{{ VER }}_gw" {
   vpc_id = "${aws_vpc.vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"
  
  tags = {
   Name = "{{ ENV }}_{{ VER }}_aws_internet_gateway"
   Version = "{{ VERSION}}"
  }
}

resource "aws_route_table" "{{ ENV }}_{{ VER }}_route-table" {
   vpc_id = "${aws_vpc.vpc_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.{{ ENV }}_{{ VER }}_gw.id}"
	}
  
  tags = {
   Name = "{{ ENV }}_{{ VER }}_aws_route_table"
   Version = "{{ VERSION}}"
  }
}

resource "aws_route_table_association" "{{ ENV }}_{{ VER }}_subnet-association" {
  subnet_id      = "${aws_subnet.subnet_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"
  route_table_id = "${aws_route_table.{{ ENV }}_{{ VER }}_route-table.id}"
  
}

resource "aws_key_pair" "{{ ENV }}_{{ VER }}_aws_key_pair" {
  key_name   = "$key_name"
  public_key = "$public_ssh_key_content"

}

resource "aws_instance" "{{ ENV }}_{{ VER }}_qto_inst" {
	ami           = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
  	subnet_id      = "${aws_subnet.subnet_{{ PROJ }}_{{ ENV }}_{{ VER }}.id}"
   associate_public_ip_address = "true"
	security_groups = ["${aws_security_group.{{ ENV }}_{{ VER }}_sgr_qto_web.id}"]
	key_name      = "$key_name"

  tags = {
   Name = "{{ ENV }}_{{ VER }}_qto-ec2"
   Version = "{{ VERSION}}"
  }
}

