terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rtb-public-to-internet"
  }
}

resource "aws_route_table_association" "rtb_public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rtb-private"
  }
}

resource "aws_route_table_association" "rtb_private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rtb_private.id
}

resource "aws_security_group" "devops_sg_public" {
  name        = "devops-sg-public"
  description = "Security group for public instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-security-group"
  }
}

resource "aws_security_group" "devops_sg_private" {
  name        = "devops-sg-private"
  description = "Security group for private instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow SSH from public instance"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.devops_sg_public.id]
  }

  tags = {
    Name = "private-security-group"
  }
}

resource "aws_instance" "frontend_server" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name      = "aws-key-pair"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [
    aws_security_group.devops_sg_public.id,
  ]

  tags = {
    Name = var.frontend_instance_name
  }
}

resource "aws_instance" "backend_server" {
  ami                         = "ami-0f918f7e67a3323f0"
  instance_type               = "t2.micro"
  key_name                    = "aws-key-pair"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids = [
    aws_security_group.devops_sg_private.id,
  ]

  tags = {
    Name = var.backend_instance_name
  }
}


