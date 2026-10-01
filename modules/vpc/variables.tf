variable "AWS_REGION" {
  description = "AWS region"
  type        = string
}

variable "VPC_NAME" {
  description = "Name of the VPC"
  type        = string
}

variable "VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "PUBLIC_SUBNET_1_CIDR" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "PUBLIC_SUBNET_1_AZ" {
  description = "Availability Zone for public subnet 1"
  type        = string
}

variable "PUBLIC_SUBNET_2_CIDR" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "PUBLIC_SUBNET_2_AZ" {
  description = "Availability Zone for public subnet 2"
  type        = string
}

variable "PRIVATE_APP_SUBNET_CIDR" {
  description = "CIDR block for the private application subnet"
  type        = string
}

variable "PRIVATE_APP_SUBNET_AZ" {
  description = "Availability Zone for the private application subnet"
  type        = string
}

variable "PRIVATE_DB_SUBNET_CIDR" {
  description = "CIDR block for the private database subnet"
  type        = string
}

variable "PRIVATE_DB_SUBNET_AZ" {
  description = "Availability Zone for the private database subnet"
  type        = string
}

variable "COMMON_TAGS" {
  description = "Common tags used by VPC resources"

  type = map(string)

  default = {}
}