variable "region" {
  type = string
  description = "AWS region"
}

variable "image_id" {
  type = string
  description = "Image ID to create instances with"
}

variable "number_of_master_nodes" {
  type = number
  description = "Number of master nodes to create"
}

variable "number_of_worker_nodes" {
  type = number
  description = "Number of master nodes to create"
}

variable "public_key_path" {
  description = "Path to public key file"
}

variable "instance_type" {
  type = string
  description = "Instance type"
}