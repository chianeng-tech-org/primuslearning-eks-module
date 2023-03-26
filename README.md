<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.35 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.35 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 18.30.2 |
| <a name="module_iam_assumable_role_admin"></a> [iam\_assumable\_role\_admin](#module\_iam\_assumable\_role\_admin) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | ~> 5.5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.18.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.node-group-AmazonEKS_EBS_CSI_DriverPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ebs-csi-controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.node_group_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.releases](https://registry.terraform.io/providers/hashicorp/helm/2.3.0/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_node_group_capacity_type"></a> [app\_node\_group\_capacity\_type](#input\_app\_node\_group\_capacity\_type) | Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT` | `string` | `"SPOT"` | no |
| <a name="input_app_node_group_desired_size"></a> [app\_node\_group\_desired\_size](#input\_app\_node\_group\_desired\_size) | n/a | `number` | `3` | no |
| <a name="input_app_node_group_disk_size"></a> [app\_node\_group\_disk\_size](#input\_app\_node\_group\_disk\_size) | Disk size in GiB for nodes. Defaults to `20` | `number` | `10` | no |
| <a name="input_app_node_group_instance_type"></a> [app\_node\_group\_instance\_type](#input\_app\_node\_group\_instance\_type) | Set instance type associated with the EKS Node Group. Default to `["t3.medium"]` | `string` | `"t3.medium"` | no |
| <a name="input_app_node_group_labels"></a> [app\_node\_group\_labels](#input\_app\_node\_group\_labels) | Node Label(s) to use with NodeSelector during deployment | `map` | <pre>{<br>  "stack": "app_node"<br>}</pre> | no |
| <a name="input_app_node_group_max_size"></a> [app\_node\_group\_max\_size](#input\_app\_node\_group\_max\_size) | n/a | `number` | `4` | no |
| <a name="input_app_node_group_min_size"></a> [app\_node\_group\_min\_size](#input\_app\_node\_group\_min\_size) | n/a | `number` | `1` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_custom_eks_cluster_addons"></a> [custom\_eks\_cluster\_addons](#input\_custom\_eks\_cluster\_addons) | Custom EKS cluster addons | `map(string)` | `{}` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_eks_additional_aws_auth_users"></a> [eks\_additional\_aws\_auth\_users](#input\_eks\_additional\_aws\_auth\_users) | Allowed aws IAM users to connect to EKS cluster | `list(string)` | `[]` | no |
| <a name="input_eks_additional_public_ips_allowed"></a> [eks\_additional\_public\_ips\_allowed](#input\_eks\_additional\_public\_ips\_allowed) | Others Public Ips Autorized | `map(string)` | `{}` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Kubernetes cluster version | `string` | `"1.23"` | no |
| <a name="input_eks_control_plane_subnet_ids"></a> [eks\_control\_plane\_subnet\_ids](#input\_eks\_control\_plane\_subnet\_ids) | A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane | `list(string)` | `[]` | no |
| <a name="input_eks_create_vpc"></a> [eks\_create\_vpc](#input\_eks\_create\_vpc) | Boolean for VPC creation | `bool` | `true` | no |
| <a name="input_eks_node_group_role"></a> [eks\_node\_group\_role](#input\_eks\_node\_group\_role) | n/a | `any` | `null` | no |
| <a name="input_eks_subnet_cidrs"></a> [eks\_subnet\_cidrs](#input\_eks\_subnet\_cidrs) | A list of subnet CIDRs where the nodes/node groups will be provisioned. | `list(string)` | `[]` | no |
| <a name="input_eks_subnet_ids"></a> [eks\_subnet\_ids](#input\_eks\_subnet\_ids) | A list of subnet IDs where the nodes/node groups will be provisioned. If `eks_control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets | `list(string)` | `[]` | no |
| <a name="input_eks_vpc_cidr"></a> [eks\_vpc\_cidr](#input\_eks\_vpc\_cidr) | The IPv4 CIDR block for the VPC. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_eks_vpc_id"></a> [eks\_vpc\_id](#input\_eks\_vpc\_id) | ID of the VPC where the cluster and its nodes will be provisioned | `string` | `null` | no |
| <a name="input_eks_vpc_private_subnet_cidr"></a> [eks\_vpc\_private\_subnet\_cidr](#input\_eks\_vpc\_private\_subnet\_cidr) | A list of private subnets inside the VPC | `list(string)` | <pre>[<br>  "10.0.16.0/20",<br>  "10.0.32.0/20"<br>]</pre> | no |
| <a name="input_eks_vpc_public_subnet_cidr"></a> [eks\_vpc\_public\_subnet\_cidr](#input\_eks\_vpc\_public\_subnet\_cidr) | A list of public subnets inside the VPC | `list(string)` | <pre>[<br>  "10.0.0.0/24",<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_helm_releases"></a> [helm\_releases](#input\_helm\_releases) | Helm releases to deploy after cluster creation | <pre>map(object({<br>    chart         = string<br>    repo          = string<br>    version       = string<br>    namespace     = string<br>    values        = list(string)<br>    set           = map(string)<br>    set_sensitive = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_install_cluster_autoscaler"></a> [install\_cluster\_autoscaler](#input\_install\_cluster\_autoscaler) | Install CA or not | `bool` | `true` | no |
| <a name="input_ip_range"></a> [ip\_range](#input\_ip\_range) | app public IPs - ip/mask | `map` | <pre>{<br>  "open": "0.0.0.0/0"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_additional_sg_id"></a> [eks\_cluster\_additional\_sg\_id](#output\_eks\_cluster\_additional\_sg\_id) | n/a |
| <a name="output_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#output\_eks\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | n/a |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | n/a |
| <a name="output_eks_cluster_primary_sg_id"></a> [eks\_cluster\_primary\_sg\_id](#output\_eks\_cluster\_primary\_sg\_id) | n/a |
| <a name="output_eks_cluster_version"></a> [eks\_cluster\_version](#output\_eks\_cluster\_version) | n/a |
| <a name="output_eks_kubeconfig"></a> [eks\_kubeconfig](#output\_eks\_kubeconfig) | n/a |
| <a name="output_eks_nodegroup_asg_name_app_ng1"></a> [eks\_nodegroup\_asg\_name\_app\_ng1](#output\_eks\_nodegroup\_asg\_name\_app\_ng1) | n/a |
| <a name="output_eks_nodegroup_iam_role_name_app_ng1"></a> [eks\_nodegroup\_iam\_role\_name\_app\_ng1](#output\_eks\_nodegroup\_iam\_role\_name\_app\_ng1) | n/a |
| <a name="output_eks_nodegroup_sg_id_app_ng1"></a> [eks\_nodegroup\_sg\_id\_app\_ng1](#output\_eks\_nodegroup\_sg\_id\_app\_ng1) | n/a |
<!-- END_TF_DOCS -->