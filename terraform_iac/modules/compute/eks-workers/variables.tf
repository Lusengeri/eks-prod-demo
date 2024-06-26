variable "cluster_ca" {
  type = any
}

variable "cluster_endpoint" {
  type = any
}

variable "cluster_full_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "control_plane_security_group_id" {
  type = string
}

variable "desired_worker_node_no" {
  type = number
}

variable "stage" {
  type = string
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

variable "ami_release_version" {
  type = string
}

variable "worker_instance_type" {
  type = string
}

variable "vpc_id" {
  type = any
}