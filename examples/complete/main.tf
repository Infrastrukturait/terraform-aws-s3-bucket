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

module "app_prod_bucket" {
    source                      = "../../"
    bucket_name                 = join(module.app_prod_bastion_label.delimiter, [module.app_prod_bastion_label.stage, module.app_prod_bastion_label.name, var.name])
    bucket_acl                  = var.bucket_acl
    lifecycle_rules             = [
      {
        id      = "log"
        enabled = true

        filter = {
          tags = {
            some    = "value"
            another = "value2"
          }
        }

        transition = [
          {
            days          = 30
            storage_class = "ONEZONE_IA"
          }, 
          {
            days          = 60
            storage_class = "GLACIER"
          }
        ]

        expiration = {
          days = 90
          expired_object_delete_marker = true
        }

        noncurrent_version_expiration = {
          newer_noncurrent_versions = 5
          days = 30
        }
      }
    ]
    tags                        = module.app_prod_bastion_label.tags
}
