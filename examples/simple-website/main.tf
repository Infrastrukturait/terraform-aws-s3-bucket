module "website_label" {
  source  = "cloudposse/label/null"
  version = "v0.25.0"

  namespace  = "app"
  stage      = "prod"
  name       = "static-website"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
  }
}

module "app_prod_bucket" {
  source      = "../../"
  bucket_name = join(module.website_label.delimiter, [module.website_label.stage, module.website_label.name, var.bucket_name])
  bucket_acl  = var.bucket_acl

  website_enabled        = true
  website_index_document = "index.html"
  website_error_document = "error.html"
  website_routing_rules  = <<-EOT
[
    {
        "Condition": {
            "KeyPrefixEquals": "images/"
        },
        "Redirect": {
            "ReplaceKeyWith": "folderdeleted.html"
        }
    }
]
EOT
  tags                   = module.website_label.tags
}
