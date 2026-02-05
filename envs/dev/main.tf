############################
# VPC
############################
module "vpc" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/vpc"

#  vpc_name        = var.vpc_name
  name        = var.vpc_name
#  cidr        = var.vpc_cidr
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

############################
# IAM
############################
module "iam" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/iam"

  name = var.cluster_name
  tags         = var.tags
}

############################
# EKS
############################
module "eks" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/eks"

  cluster_name      = var.cluster_name
#  cluster_version   = var.cluster_version
  vpc_id            = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  node_desired      = var.node_desired
  node_min          = var.node_min
  node_max          = var.node_max
  eks_role_arn      = module.iam.eks_cluster_role_arn
  node_role_arn     = module.iam.node_role_arn
#  tags              = var.tags
}

############################
# Security Group
############################
module "security_group" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/security_group"

  name        = var.name
  description = var.description
  vpc_id      = module.vpc.vpc_id
  ingress     = var.ingress
  egress      = var.egress
  tags        = var.tags
}

############################
# ALB
############################
module "alb" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/alb"

  name              = var.name
  vpc_id            = module.vpc.vpc_id
  subnets           = module.vpc.public_subnet_ids
  security_groups   = [module.security_group.sg_id]

  listener_port     = var.listener_port
  listener_protocol = var.listener_protocol
  target_port       = var.target_port
  target_protocol   = var.target_protocol
  target_type       = var.target_type

  health_path       = var.health_path
  health_protocol   = var.health_protocol
  health_matcher    = var.health_matcher

  tags              = var.tags
}

############################
# NLB
############################
module "nlb" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/nlb"

  name            = var.name
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  listener_port   = var.listener_port
  target_port     = var.target_port
  target_protocol = var.target_protocol
  tags            = var.tags
}

############################
# WAF
############################
module "waf" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/waf"

  name               = var.name
  scope              = var.scope
#  load_balancer_arn  = module.alb.alb_arn
#  arn  = module.alb.alb_arn
  block_ips          = var.block_ips
  tags               = var.tags
}

############################
# API Gateway
############################
module "apigateway" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/apigateway"

  name           = var.name
  authorization  = var.authorization
  tags           = var.tags
}

############################
# KMS
############################
module "kms" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/kms_policies"
  alias_name = var.kms_key_alias
  kms_key_alias = var.kms_key_alias
#  name = var.name
}

############################
# S3
############################
module "s3" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/s3"

  bucket_name            = var.bucket_name
  acl                    = var.acl
  versioning             = var.versioning
  force_destroy          = var.force_destroy
  sse_algorithm          = var.sse_algorithm
  block_public_acls      = var.block_public_acls
  block_public_policy    = var.block_public_policy
  ignore_public_acls     = var.ignore_public_acls
  restrict_public_buckets= var.restrict_public_buckets
  lifecycle_enabled      = var.lifecycle_enabled
  lifecycle_days         = var.lifecycle_days
  tags                   = var.tags
}

############################
# RDS
############################
module "rds" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/rds"

  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  username             = var.username
  password             = var.password
  subnet_ids           = module.vpc.private_subnet_ids
#  vpc_security_group_ids = [module.security_group.sg_id]
  parameter_family     = var.parameter_family
  multi_az             = var.multi_az
  backup_retention     = var.backup_retention
  storage_encrypted    = var.storage_encrypted
  skip_final_snapshot  = var.skip_final_snapshot
  tags                 = var.tags
}

############################
# Notifications (SNS)
############################
module "notifications" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/notifications"

  name         = var.name
  email        = var.email
  sms_numbers  = var.sms_numbers
  tags         = var.tags
}

############################
# Route53
############################
module "route53" {
  source = "git::https://github.com/rajan0917/terraform-aws-modules-05022025.git//modules/route53"

  zone_id = var.zone_id
  domain  = var.domain
#  alb_dns = module.alb.alb_dns_name
  eks_endpoint = module.eks.cluster_endpoint
}
