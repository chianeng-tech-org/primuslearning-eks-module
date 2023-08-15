default_tags = {
  Environment : "dev"
  Team : "alpha"
  Account : "primus-learning"
}

app_node_group_desired_size = 5
app_node_group_max_size = 6
app_node_group_min_size = 1

aws_region = "us-east-1"
eks_vpc_cidr = "10.0.0.0/16"
eks_vpc_public_subnet_cidr = [ "10.0.0.0/24", "10.0.1.0/24" ]
eks_vpc_private_subnet_cidr = [ "10.0.16.0/20", "10.0.32.0/20" ]