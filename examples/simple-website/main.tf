locals {
  bucket_name = join(module.website_label.delimiter, [module.website_label.stage, module.website_label.name, var.bucket_name])
}

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

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"

    actions = ["s3:GetObject"]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
  }
}

module "app_prod_bucket" {
  source                  = "../../"
  bucket_name             = local.bucket_name
  bucket_object_ownership = "BucketOwnerEnforced"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

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

  bucket_policy = data.aws_iam_policy_document.bucket_policy.json

  tags = module.website_label.tags
}

resource "aws_s3_object" "first_file" {
  key    = "index.html"
  bucket = module.app_prod_bucket.id
  source = "website/index.html"
  etag   = filemd5("website/index.html")

  depends_on = [
    module.app_prod_bucket
  ]
}

resource "aws_s3_object" "second_file" {
  key    = "folderdeleted.html"
  bucket = module.app_prod_bucket.id
  source = "website/folderdeleted.html"
  etag   = filemd5("website/folderdeleted.html")

  depends_on = [
    module.app_prod_bucket
  ]
}
