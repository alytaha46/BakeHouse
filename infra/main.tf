module "vpc" {
  source = "terraform-aws-modules/vpc/aws"  
  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.vpc_azs 
  private_subnets    = var.private_subnets     
  public_subnets     = var.public_subnets      
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  tags = var.tags
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_addons = var.cluster_addons
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets
  eks_managed_node_groups = var.eks_managed_node_groups
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  access_entries = var.access_entries
  tags = var.tags
}