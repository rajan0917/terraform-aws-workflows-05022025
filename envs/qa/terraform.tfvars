region         = "ap-south-1"
cluster_name   = "qa-eks"
vpc_name       = "qa-vpc"
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
azs             = ["ap-south-1a", "ap-south-1b"]
zone_id = "Z123456789"
domain  = "example.com"
node_desired = 2
node_min     = 1
node_max     = 3
name = "app-alb"
subnets = ["subnet-aaa","subnet-bbb"]
security_groups = ["sg-aaa"]
vpc_id = "vpc-123456"
target_port = 80
target_protocol = "HTTP"
listener_port = 80
listener_protocol = "HTTP"
health_path = "/health"
health_protocol = "HTTP"
health_matcher = "200-399"
tags = { Environment = "qa" }
description = "Proxy API for my app"
authorization = "NONE"
target_type = "instance"
email = "ops-team@example.com"
sms_numbers = []
identifier = "qa-db"
engine = "postgres"
engine_version = "15"
instance_class = "db.t3.micro"
allocated_storage = 20
username = "dbadmin"
password = "CHANGE_ME"
subnet_ids = ["subnet-priv-1","subnet-priv-2"]
parameter_family = "postgres15"
multi_az = false
skip_final_snapshot = true
backup_retention = 7
storage_encrypted = true
bucket_name = "my-app-bucket-qa"
acl = "private"
force_destroy = false
sse_algorithm = "aws:kms"
versioning = true
lifecycle_enabled = true
lifecycle_days = 365
block_public_acls = true
block_public_policy = true
restrict_public_buckets = true
ignore_public_acls = true
Environment = "qa"
Team = "platform"
ingress = [
{ 
from_port = 80, 
to_port = 80, 
protocol = "tcp", 
cidr_blocks = ["0.0.0.0/0"] 
}
]
egress = [
{
    from_port   = 0,
    to_port     = 0,
    protocol    = "-1",
    cidr_blocks = ["0.0.0.0/0"]
  }
]
scope = "REGIONAL"
block_ips = ["203.0.113.0/32"]
