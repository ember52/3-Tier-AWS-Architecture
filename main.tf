module "iam_roles" {
  source  = "./modules/iam_roles"
  project = var.project
}

module "networking" {
  source   = "./modules/networking"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  project  = var.project
}

module "compute" {
  vpc_id                      = module.networking.vpc_id
  source                      = "./modules/compute"
  project                     = var.project
  public_subnets              = module.networking.public_subnets
  private_subnets             = module.networking.private_subnets
  public_security_group       = module.networking.security_groups.bastion
  private_security_group      = module.networking.security_groups.app
  public_alb_security_group   = module.networking.security_groups.bastion
  internal_alb_security_group = module.networking.security_groups.app

  app_instance_profile_name = module.iam_roles.app_instance_profile_name
}



module "rds" {
  source = "./modules/rds"

  project             = var.project
  database_subnet_ids = module.networking.private_subnets # Using private subnets for RDS
  db_username         = var.db_username
  db_password         = var.db_password

  # Security groups: Use the database security group from the networking module
  db_security_group_id = module.networking.security_groups["db"]
}

