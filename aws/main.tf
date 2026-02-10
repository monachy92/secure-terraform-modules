module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "storage" {
  count       = var.deploy_storage ? 1 : 0
  source      = "./modules/storage"
  bucket_name = "${var.env_name}-secure-data"
}

module "compute" {
  # This module only deploys if 'deploy_compute' is true
  count     = var.deploy_compute ? 1 : 0
  source    = "./modules/compute"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.private_subnet_id
}
