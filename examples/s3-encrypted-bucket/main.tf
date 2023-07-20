module "bucket_label" {
  source  = "cloudposse/label/null"
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

module "bucket_kms_key" {
  source                  = "Infrastrukturait/kms-key/aws"
  version                 = "0.1.0"
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = false

  tags = module.bucket_label.tags
}

module "app_prod_bucket" {
  source                    = "../../"
  bucket_name               = join(module.bucket_label.delimiter, [module.bucket_label.stage, module.bucket_label.name, var.bucket_name])
  bucket_acl                = var.bucket_acl
  encryption_enabled        = true
  encryption_master_kms_key = module.bucket_kms_key.key_arn
  tags                      = module.bucket_label.tags
}
