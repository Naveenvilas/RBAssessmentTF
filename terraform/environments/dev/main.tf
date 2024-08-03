provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = "rbassmnt-state-bucket-"
  force_destroy = true # Allows bucket to be deleted even if it contains objects

  tags = {
    Name        = "terraform-state-bucket"
    Environment = "dev"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-locks"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST" # Use "PROVISIONED" if you need to set read/write capacity
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-locks"
    Environment = "dev"
  }
}


module "vpc" {
  source = "../../modules/vpc"
  name = "dev-vpc"
  cidr_block = "10.0.0.0/16"
  azs = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "iam" {
  source = "../../modules/iam"
}

module "eks" {
  source = "../../modules/eks"
  cluster_name = "dev-eks-cluster"
  cluster_version = "1.28"
  subnets = module.vpc.private_subnets
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn = module.iam.eks_node_group_role_arn
  node_instance_type = "t3.medium"
  desired_capacity = 2
  max_capacity = 3
  min_capacity = 1
}

output "s3_bucket_id" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

