variable "bucket_name" {
  type        = string
  description = "Name of the bucket. If omitted, Terraform will assign a random, unique name."
}

variable "bucket_acl" {
  type        = string
  default     = null
  description = <<-EOT
    The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply.
    We recommend `private` to avoid exposing sensitive information. When `website_enabled` override by `public-read`
  EOT
}

variable "bucket_policy" {
  description = "A bucket policy in JSON format"
  type        = string
  default     = ""
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the ignoring of public access lists on the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the restricting of making the bucket public"
}

variable "website_enabled" {
  type        = bool
  default     = false
  description = "Enable static website hosting on bucket."
}

variable "website_index_document" {
  type        = string
  default     = null
  description = "The name of the index document for the website."
}

variable "website_error_document" {
  type        = string
  default     = null
  description = "The name of the index document for the website."
}

variable "website_routing_rules" {
  type        = string
  default     = null
  description = <<-EOT
    Routing rules to website in JSON format
    Example routing rule from `KeyPrefix` equaled to `images` to `folderdeleted.html` object:
    ```
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
    ```
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to assign to bucket."
}


