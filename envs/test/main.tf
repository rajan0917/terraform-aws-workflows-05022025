#provider "aws" {
#  region = var.region
#}

module "vpc" {
  source = "../../modules/vpc"

  name            = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "eks" {
  source = "../../modules/eks"

  vpc_id             = module.vpc.vpc_id
  cluster_name       = var.cluster_name
  eks_role_arn       = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  node_desired 	     = var.node_desired
  node_min           = var.node_min
  node_max           = var.node_max
}

module "route53" {
  source = "../../modules/route53"

  zone_id      = var.zone_id
  domain       = var.domain
  eks_endpoint = module.eks.cluster_endpoint
}
module "iam" {
  source = "../../modules/iam"
  name   = var.cluster_name
}

