output "id" {
  description = "The name of the bucket."
  value       = module.app_prod_bucket.id
}

output "arn" {
  description = "The ARN of the bucket."
  value       = module.app_prod_bucket.arn
}

output "bucket_domain_name" {
  description = "The domain name of the bucket."
  value       = module.app_prod_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The region-specific domain name of the bucket."
  value       = module.app_prod_bucket.bucket_regional_domain_name
}
