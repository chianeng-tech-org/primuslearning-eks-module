output "eks_kubeconfig" {
  value = local.kubeconfig
}

output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_additional_sg_id" {
  value = module.eks.cluster_security_group_id
}

output "eks_cluster_primary_sg_id" {
  value = module.eks.cluster_primary_security_group_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_version" {
  value = module.eks.cluster_version
}

output "eks_nodegroup_asg_name_app_ng1" {
  value = try(module.eks.eks_managed_node_groups["${local.eks_app_ng1_key}"].node_group_resources[0].autoscaling_groups[0].name, null)
}


output "eks_nodegroup_sg_id_app_ng1" {
  value = module.eks.eks_managed_node_groups["${local.eks_app_ng1_key}"].security_group_id
}


output "eks_nodegroup_iam_role_name_app_ng1" {
  value = module.eks.eks_managed_node_groups["${local.eks_app_ng1_key}"].iam_role_name
}


