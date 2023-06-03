variable "desired_worker_node_no" {
  type = number
}

variable "max_worker_node_no" {
  type = number
}

variable "min_worker_node_no" {
  type = number
}

variable "namespace" {
  type = string 
}

variable "subnet_ids" {
  type = list(string) 
}

variable "vpc_id" {
  type = string
}

variable "worker_ami_id" {
  type = string 
}

variable "worker_instance_type" {
  type = string 
}

variable "worker_key_name" {
  type = string
}