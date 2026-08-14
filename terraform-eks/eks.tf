module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.cluster_name
  kubernetes_version = "1.33"
  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }
  # Optional
  endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets


eks_managed_node_groups = {
  tws-cluster-ng = {
    # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups

    instance_types = ["t2.medium"]
    attach_cluster_primary_security_group = true

    min_size     = 2
    max_size     = 3
    desired_size = 2

    capacity_type = "SPOT"
  }
}

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}