variable "internet_gateway" {
  type = any
}

variable "namespace" {
  type = string
}

variable "nat_subnet_id" {
  type = any
}

variable "private_subnet_id" {
  type = any
}

variable "stage" {
  type = string 
    
  validation {
    condition     = contains(["tst", "dev", "stg", "prd"], var.stage)
    error_message = "The specified deployment stage must be one of 'tst', 'dev', 'stg', or 'prd'."
  }
}

variable "vpc_id" {
  type = string 
}