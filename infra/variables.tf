variable "tags" {
  type        = map(any)
  description = "Map of Default Tags"
}

############################################
################ VPC #######################
############################################

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Flag to enable NAT Gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Flag to use a single NAT Gateway"
  type        = bool
  default     = true
}

############################################
################ EKS #######################
############################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDRs allowed to access the public endpoint"
  type        = list(string)
}

variable "cluster_addons" {
  description = "Map of cluster add-ons"
  type        = map(any)
}

variable "eks_managed_node_groups" {
  description = "Configuration for EKS managed node groups"
  type        = map(any)
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Enable admin permissions for the cluster creator"
  type        = bool
  default     = true
}

variable "access_entries" {
  description = "Access entries for EKS cluster"
  type        = map(any)
}