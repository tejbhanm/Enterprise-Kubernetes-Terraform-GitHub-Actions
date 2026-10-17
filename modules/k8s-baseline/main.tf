resource "kubernetes_namespace_v1" "secure_ns" {
  for_each = toset(var.namespaces)

  metadata {
    name = each.value
    labels = {
      "pod-security.kubernetes.io/enforce" = "restricted"
      "pod-security.kubernetes.io/audit"   = "restricted"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  }
}

resource "kubernetes_network_policy_v1" "default_deny_all" {
  for_each = toset(var.namespaces)

  metadata {
    name      = "default-deny-all"
    namespace = kubernetes_namespace_v1.secure_ns[each.key].metadata[0].name
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

resource "kubernetes_service_account_v1" "app_sa" {
  for_each = toset(var.namespaces)

  metadata {
    name      = "workload-sa"
    namespace = kubernetes_namespace_v1.secure_ns[each.key].metadata[0].name
  }
  automount_service_account_token = false
}
