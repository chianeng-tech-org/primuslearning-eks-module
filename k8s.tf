resource "helm_release" "releases" {

  for_each = local.releases

  name             = each.key
  chart            = each.value.chart
  repository       = each.value.repo
  version          = each.value.version
  namespace        = each.value.namespace
  create_namespace = true
  reuse_values     = true
  force_update     = true
  recreate_pods    = false
  timeout          = 600

  values = each.value.values

  dynamic "set" {
    for_each = each.value.set
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = each.value.set_sensitive
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [
    module.eks.eks_managed_node_groups,
    data.aws_iam_role.cluster_autoscaler,
  ]
}
