variable "cluster_ca" {
  type = any 
}

variable "control_plane_security_group_id" {
  type = string
}

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
  type = list(any) 
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

variable "vpc_id" {
  type = any
}