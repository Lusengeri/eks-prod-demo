variable "cluster_name" {
  type = string
}

variable "data_bucket_arn" {
  type = string
}

variable "desired_worker_node_no" {
  type = number
}

variable "environment" {
  type = string
}

variable "kubernetes_version" {
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

variable "private_subnets_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
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