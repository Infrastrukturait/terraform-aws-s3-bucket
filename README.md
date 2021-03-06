
# terraform-aws-s3-bucket

[![WeSupportUkraine](https://raw.githubusercontent.com/Infrastrukturait/WeSupportUkraine/main/banner.svg)](https://github.com/Infrastrukturait/WeSupportUkraine)
## About
Terraform base module for creating a secure [AWS S3-Bucket](https://aws.amazon.com/s3/).
## License

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

```text
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
## Authors
- Rafał Masiarek | [website](https://masiarek.pl) | [email](mailto:rafal@masiarek.pl) | [github](https://github.com/rafalmasiarek)
<!-- BEGIN_TF_DOCS -->
## Documentation



### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Set to `false` to disable the blocking of new public access lists on the bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Set to `false` to disable the blocking of new public policies on the bucket. | `bool` | `true` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply.<br>We recommend `private` to avoid exposing sensitive information. When `website_enabled` override by `public-read`. | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket. If omitted, Terraform will assign a random, unique name. | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | A bucket policy in JSON format | `string` | `""` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Boolean to enable server-side encryption for S3 bucket. | `bool` | `false` | no |
| <a name="input_encryption_master_kms_key"></a> [encryption\_master\_kms\_key](#input\_encryption\_master\_kms\_key) | AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of `encryption_sse_algorithm` as `aws:kms`<br>When empty in use is default aws/s3 AWS KMS master key provided by AWS. | `string` | `""` | no |
| <a name="input_encryption_sse_algorithm"></a> [encryption\_sse\_algorithm](#input\_encryption\_sse\_algorithm) | server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms` | `string` | `"aws:kms"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. | `bool` | `false` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Set to `false` to disable the ignoring of public access lists on the bucket. | `bool` | `true` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Set to `false` to disable the restricting of making the bucket public. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to bucket. | `map(string)` | `{}` | no |
| <a name="input_website_enabled"></a> [website\_enabled](#input\_website\_enabled) | Enable static website hosting on bucket. | `bool` | `false` | no |
| <a name="input_website_error_document"></a> [website\_error\_document](#input\_website\_error\_document) | The name of the index document for the website. | `string` | `null` | no |
| <a name="input_website_index_document"></a> [website\_index\_document](#input\_website\_index\_document) | The name of the index document for the website. | `string` | `null` | no |
| <a name="input_website_routing_rules"></a> [website\_routing\_rules](#input\_website\_routing\_rules) | Routing rules to website in JSON format<br>Example routing rule from `KeyPrefix` equaled to `images` to `folderdeleted.html` object:<pre>[<br>    {<br>        "Condition": {<br>            "KeyPrefixEquals": "images/"<br>        },<br>        "Redirect": {<br>            "ReplaceKeyWith": "folderdeleted.html"<br>        }<br>    }<br>]</pre> | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The domain name of the bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The region-specific domain name of the bucket. |
| <a name="output_id"></a> [id](#output\_id) | The name of the bucket. |

### Examples

```hcl
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
    tags                        = module.app_prod_bastion_label.tags
}
```
<!-- END_TF_DOCS -->
