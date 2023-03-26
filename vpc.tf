module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.18.1"

  count = var.eks_create_vpc ? 1 : 0
  name  = local.vpc_name
  cidr  = var.eks_vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = var.eks_vpc_private_subnet_cidr
  public_subnets  = var.eks_vpc_public_subnet_cidr


  //database_subnets = var.database_subnets

  enable_dns_hostnames               = true
  enable_nat_gateway                 = true
  single_nat_gateway                 = true
  enable_vpn_gateway                 = false
  create_database_subnet_group       = false
  create_database_subnet_route_table = false

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  tags = merge(tomap({
    "Name"                                    = "${local.vpc_name}",
    "kubernetes.io/cluster/${local.eks_name}" = "shared",
  }), var.default_tags)

}


