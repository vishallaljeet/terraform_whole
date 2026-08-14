module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.cluster_name}-vpc"
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  # Only the 3 public subnets get these extra tags
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }

  # Only the 3 private subnets get these extra tags
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }
  tags = {
    Terraform = "true"
    Environment = local.env
  }
}