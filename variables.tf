################### Global Variables #################

variable "aws_region" {
  default = "us-east-1"
}

variable "default_tags" {
  type = map(string)
}

variable "ip_range" {
  description = "app public IPs - ip/mask"
  default = { // "description" = "ip/mask"
    "open" = "0.0.0.0/0"
  }
}

############ VPC #############

variable "eks_create_vpc" {
  description = "Boolean for VPC creation"
  type        = bool
  default     = true
}

variable "eks_vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "eks_vpc_public_subnet_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "eks_vpc_private_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.16.0/20", "10.0.32.0/20"]
}



############ EKS #############

variable "eks_vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
  default     = null
}
variable "eks_control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
  default     = []
}
variable "eks_subnet_ids" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `eks_control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
  type        = list(string)
  default     = []
}
variable "eks_subnet_cidrs" {
  description = "A list of subnet CIDRs where the nodes/node groups will be provisioned."
  type        = list(string)
  default     = []
}
variable "eks_cluster_version" {
  description = "Kubernetes cluster version"
  default     = "1.23"
}
variable "eks_node_group_role" {
  default = null
}
variable "app_node_group_capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`"
  type        = string
  default     = "SPOT"
}
variable "app_node_group_instance_type" {
  description = "Set instance type associated with the EKS Node Group. Default to `[\"t3.medium\"]`"
  type        = string
  default     = "t3.medium"
}
variable "app_node_group_desired_size" { default = 3 }
variable "app_node_group_max_size" { default = 4 }
variable "app_node_group_min_size" { default = 1 }
variable "app_node_group_disk_size" {
  description = "Disk size in GiB for nodes. Defaults to `20`"
  type        = number
  default     = 10
}
variable "app_node_group_labels" {
  description = "Node Label(s) to use with NodeSelector during deployment"
  default     = { stack = "app_node" }
}
variable "eks_additional_aws_auth_users" {
  type        = list(string)
  description = "Allowed aws IAM users to connect to EKS cluster"
  default     = []
}
variable "custom_eks_cluster_addons" {
  description = "Custom EKS cluster addons"
  type        = map(string)
  default     = {}
}
variable "eks_additional_public_ips_allowed" {
  type        = map(string)
  description = "Others Public Ips Autorized"
  default     = {}
}


########### K8S #################

variable "helm_releases" {
  description = "Helm releases to deploy after cluster creation"
  type = map(object({
    chart         = string
    repo          = string
    version       = string
    namespace     = string
    values        = list(string)
    set           = map(string)
    set_sensitive = map(string)
  }))
  default = {}
}
variable "install_cluster_autoscaler" {
  description = "Install CA or not"
  type        = bool
  default     = true
}

