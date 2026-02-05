########################
# Core / Global
########################
variable "region" {
  type = string
}

variable "Environment" {
  type    = string
  default = "prod"
}

variable "Team" {
  type    = string
  default = "platform"
}

variable "tags" {
  type    = map(string)
  default = {}
}

########################
# VPC
########################
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "subnets" {
  type    = list(string)
  default = []
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "azs" {
  type = list(string)
}

variable "vpc_id" {
  type    = string
  default = null
}

########################
# EKS
########################
variable "cluster_name" {
  type = string
}

variable "node_desired" {
  type    = number
  default = 2
}

variable "node_min" {
  type    = number
  default = 1
}

variable "node_max" {
  type    = number
  default = 3
}

########################
# Route53
########################
variable "zone_id" {
  type = string
}

variable "domain" {
  type = string
}

########################
# Load Balancer (ALB / NLB)
########################
variable "name" {
  type = string
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "target_port" {
  type    = number
  default = 80
}

variable "target_protocol" {
  type    = string
  default = "HTTP"
}

variable "target_type" {
  type    = string
  default = "ip"
}

variable "health_path" {
  type    = string
  default = "/"
}

variable "health_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_matcher" {
  type    = string
  default = "200"
}

variable "security_groups" {
  type    = list(string)
  default = []
}

########################
# Security Group Rules
########################
variable "cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "from_port" {
  type    = number
  default = 80
}

variable "to_port" {
  type    = number
  default = 80
}

variable "protocol" {
  type    = string
  default = "tcp"
}

variable "ingress" {
  type    = any
  default = []
}

variable "egress" {
  type    = any
  default = []
}

variable "description" {
  type    = string
  default = ""
}

########################
# S3
########################
variable "bucket_name" {
  type = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "versioning" {
  type    = bool
  default = false
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "sse_algorithm" {
  type    = string
  default = "AES256"
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "lifecycle_enabled" {
  type    = bool
  default = false
}

variable "lifecycle_days" {
  type    = number
  default = 30
}

########################
# RDS
########################
variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "parameter_family" {
  type = string
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention" {
  type    = number
  default = 7
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

########################
# Notifications
########################
variable "email" {
  type    = string
  default = null
}

variable "sms_numbers" {
  type    = list(string)
  default = []
}

########################
# WAF / KMS
########################
variable "scope" {
  type    = string
  default = "REGIONAL"
}

variable "block_ips" {
  type    = list(string)
  default = []
}

variable "authorization" {
  type    = string
  default = "NONE"
}

