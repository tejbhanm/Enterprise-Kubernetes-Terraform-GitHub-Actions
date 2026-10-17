variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "cluster_name" {
  type        = string
  description = "Name of the target cluster"
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to deploy"
}
