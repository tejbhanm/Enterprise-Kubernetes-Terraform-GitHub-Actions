module "k8s_baseline" {
  source = "../../modules/k8s-baseline"

  environment  = var.environment
  cluster_name = var.cluster_name
  namespaces   = var.namespaces
}
