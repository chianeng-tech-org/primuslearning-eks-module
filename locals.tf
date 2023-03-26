locals {
  prefix_naming = lower("${lookup(var.default_tags, "Team")}-${lookup(var.default_tags, "Environment")}")

  vpc_name = format("%.30s", "${local.prefix_naming}-vpc")

  eks_vpc_id                   = var.eks_create_vpc ? module.vpc.0.vpc_id : var.eks_vpc_id
  eks_control_plane_subnet_ids = var.eks_create_vpc ? try(module.vpc.0.intra_subnets, []) : var.eks_control_plane_subnet_ids
  eks_subnet_ids               = var.eks_create_vpc ? module.vpc.0.private_subnets : var.eks_subnet_ids
  eks_subnet_cidrs             = var.eks_create_vpc ? module.vpc.0.private_subnets_cidr_blocks : var.eks_subnet_cidrs


  eks_name                    = format("%.30s", "${local.prefix_naming}-app")
  eks_app_ng1_key             = lower("${lookup(var.default_tags, "Account")}_app_ng1")
  eks_ng_name                 = format("%.30s", "${local.prefix_naming}-ngrp")
  eks_endpoint_private_access = true
  eks_endpoint_public_access  = true

  eks_public_ips_allowed = merge(
    { // "description" = "ip/mask"
      "internet" = "0.0.0.0/0",
    },
    var.eks_additional_public_ips_allowed
  )

  eks_cluster_addons = merge(
    {
      coredns    = { resolve_conflicts = "OVERWRITE" }
      kube-proxy = {}
      vpc-cni    = { resolve_conflicts = "OVERWRITE" }
      aws-ebs-csi-driver = {
        resolve_conflicts        = "OVERWRITE"
        service_account_role_arn = aws_iam_role.ebs-csi-controller.arn
      }
    },
    var.custom_eks_cluster_addons,
  )

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${module.eks.cluster_id}"
KUBECONFIG



  aws_ns     = "aws-system"
  ca_sa_name = "cluster-autoscaler"
  cluster_autoscaler = var.install_cluster_autoscaler ? {
    aws-ca = {
      chart     = "cluster-autoscaler"
      repo      = "https://kubernetes.github.io/autoscaler"
      version   = "9.10.3"
      namespace = local.aws_ns
      values = [
        <<-EOF
        autoDiscovery:
          clusterName: ${module.eks.cluster_id}
        awsRegion: ${var.aws_region}
        rbac:
          serviceAccount:
            name: "${local.ca_sa_name}"
            annotations:
              "eks.amazonaws.com/role-arn": "${data.aws_iam_role.cluster_autoscaler.arn}"
        podAnnotations:
          "cluster-autoscaler.kubernetes.io/safe-to-evict": "false"
        extraArgs:
          v: 4
          stderrthreshold: info
          logtostderr: true
          skip-nodes-with-system-pods: false
          skip-nodes-with-local-storage: false
          expander: least-waste
          balance-similar-node-groups: true
        EOF
      ]
      set           = {}
      set_sensitive = {}
    }
  } : {}

  releases = merge(
    local.cluster_autoscaler,
    var.helm_releases,
  )
}