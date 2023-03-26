
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.30.2"

  cluster_name    = local.eks_name
  cluster_version = var.eks_cluster_version
  vpc_id          = local.eks_vpc_id
  subnet_ids      = coalescelist(local.eks_control_plane_subnet_ids, local.eks_subnet_ids)

  cluster_endpoint_private_access      = local.eks_endpoint_private_access
  cluster_endpoint_public_access       = local.eks_endpoint_public_access
  cluster_endpoint_public_access_cidrs = values(local.eks_public_ips_allowed)
  cluster_addons                       = local.eks_cluster_addons

  enable_irsa = true

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    disk_size                  = 10
    create_launch_template     = true
    update_default_version     = true
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {
    "${local.eks_app_ng1_key}" = {
      name_prefix    = local.eks_ng_name
      subnet_ids     = local.eks_subnet_ids
      capacity_type  = var.app_node_group_capacity_type
      disk_size      = var.app_node_group_disk_size
      min_size       = var.app_node_group_min_size
      max_size       = var.app_node_group_max_size
      desired_size   = var.app_node_group_desired_size
      instance_types = [var.app_node_group_instance_type]
      iam_role_name  = "${local.eks_name}_app_ng1_role"

      labels = var.app_node_group_labels

      tags = merge(tomap({
        "Description"                                 = "EKS managed node group for ${local.prefix_naming}",
        "k8s.io/cluster-autoscaler/enabled"           = "true",
        "k8s.io/cluster-autoscaler/${local.eks_name}" = "owned"
      }), var.default_tags)
    }
  }


  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules and node to external
  node_security_group_additional_rules = {
    ingress_privsub_all = {
      description = "priv subnets all ingress ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = local.eks_subnet_cidrs
    }
    egress_privsub_all = {
      description = "priv subnets all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = local.eks_subnet_cidrs
    }

    egress_all = {
      description = "allow all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}


