variable "frontend_instance_name" {
  description = "Value of the Name tag for Frontend aws_instance"
  type        = string
  default     = "frontend-server"
}

variable "backend_instance_name" {
  description = "Value of the Name tag for Backend aws_instance"
  type        = string
  default     = "backend-server"
}

variable "bastion_instance_name" {
  description = "Value of the Name tag for Bastion aws_instance"
  type        = string
  default     = "bastion-server"
}

variable "vpc_name" {
  description = "Value of the Name tag for aws_vpc"
  type        = string
  default     = "devops-vpc"
}

variable "public_subnet_name" {
  description = "Value of the Name tag for aws_subnet"
  type        = string
  default     = "devops-public-subnet"
}

variable "private_subnet_name" {
  description = "Value of the Name tag for aws_subnet"
  type        = string
  default     = "devops-private-subnet"
}


variable "base_cidr_block" {
  description = "Value of the cidr block for aws_vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Value of the cidr block for public aws_subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Value of the cidr block for private aws_subnet"
  default     = "10.0.2.0/24"
}