variable "availability_zones" {
  description = "the availability zones within the current region in which to deploy infrastructure"
  type        = list(string)
}

variable "database_subnets" {
  description = "the cidr blocks of the database subnets"
  type        = list(string)
  default = []
}

variable "has_igw" {
  default     = true
  description = "specifies whether an internet gateway is created for the vpc"
  type        = bool
}

variable "namespace" {
  description = "the namespace of the module resources"
  type        = string
}

variable "private_subnets" {
  description = "the cidr blocks of the private subnets"
  type        = list(string)
  default = []
}

variable "public_subnets" {
  description = "the cidr blocks of the public subnets"
  type        = list(string)
  default = []
}

variable "vpc_cidr_block" {
  description = "the groups of addresses to be used as private ip addresses within the vpc"
  type        = string
}