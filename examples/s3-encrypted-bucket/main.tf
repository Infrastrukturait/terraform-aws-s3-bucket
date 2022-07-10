module "app_prod_bastion_label" {
  source   = "cloudposse/label/null"
  version = "v0.25.0"

  namespace  = "app"
  stage      = "prod"
  name       = "logs"
  attributes = ["private"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
  }
}

module "app_prod_bastion_bucket_key" {
  source                  = "Infrastrukturait/kms-key/aws"
  version                 = "0.1.0"
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = false

  tags                    = module.app_prod_kms_label.tags  
}

module "app_prod_bucket" {
    source                      = "../../"
    bucket_name                 = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.name])
    bucket_acl                  = var.bucket_acl
    encryption_enabled          = true
    encryption_master_kms_key   = module.app_prod_bastion_bucket_key.key_arn
    tags                        = module.app_prod_bastion_label.tags
}
