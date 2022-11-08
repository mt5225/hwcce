variable "vpc_cidr" {
  type        = string
  description = "(Optional) VPC CIDR"
  default     = "10.58.0.0/16"
}

variable "cce_subnet_cidr" {
  type        = string
  description = "(Optional) CCE CIDR"
  default     = "10.58.0.0/16"
}

variable "cce_gateway_ip" {
  type        = string
  description = "(Optional) CCE gateway ip"
  default     = "10.58.0.1"
}

variable "dns" {
  type        = map(string)
  description = "(Optional) dns pair"
  default = {
    primary_dns   = "100.125.1.250"
    secondary_dns = "100.125.21.250"
  }
}

variable "name" {
  type        = string
  description = "(Optional) naming prefix"
  default     = "acme"
}

variable "cluster_flavor" {
  type        = string
  description = "(Optional) flavor"
  default     = "cce.s1.small"
}

variable "num_node" {
  type        = number
  description = "number of nodes"
  default     = 2
}

variable "node_flavor" {
  type        = string
  description = "(Optional) flavor"
  default     = "s3.large.2"
}
