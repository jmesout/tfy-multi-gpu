variable "cluster_name" {
    type    = string
    default = "tfy-multi-gpu-test"
}

variable "cluster_node_size" {
    type    = string
    # 4x a100 40gb
    default = "g4g.40.kube.large"
}

variable "cluster_node_count" {
  type        = number
  default     = "1"
}

# Civo configuration

variable "civo_token" {}

variable "region" {
  type        = string
  default     = "LON1"
  description = "The region to provision the cluster against"
}
