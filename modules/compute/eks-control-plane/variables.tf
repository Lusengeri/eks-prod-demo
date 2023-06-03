variable "namespace" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "vpc_id" {
  type = any
}

variable "workers_sg_ids" {
  type = list(any) 
}