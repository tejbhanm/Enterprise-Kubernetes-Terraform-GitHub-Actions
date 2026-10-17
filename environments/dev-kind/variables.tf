variable "environment" {
  description = "Target deployment environment"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Local Kind cluster name"
  type        = string
  default     = "dev-local"
}

variable "namespaces" {
  description = "List of namespaces to provision"
  type        = list(string)
  default     = ["workloads", "monitoring"]
}
