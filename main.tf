locals {
  bucket_arn                  = "arn:aws:s3:::${var.bucket_name}"
  bucket_acl                  = var.website_enabled ? "public-read" : var.bucket_acl

  public_access_block_enabled = var.block_public_acls || var.block_public_policy || var.ignore_public_acls || var.restrict_public_buckets
  bucket_policy_enabled       = var.bucket_policy == "" ? false : true
}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags          = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.encryption_enabled ? 1 : 0
  bucket = var.bucket_name

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.encryption_master_kms_key
      sse_algorithm     = var.encryption_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = tobool(local.bucket_policy_enabled) ? 1 : 0
  bucket = var.bucket_name
  policy = var.bucket_policy
}

resource "aws_s3_bucket_acl" "this" {
  bucket = var.bucket_name
  acl    = local.bucket_acl
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = tobool(local.public_access_block_enabled) ? 1 : 0
  bucket = var.bucket_name

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = var.website_enabled ? 1 : 0
  bucket = var.bucket_name

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }

  routing_rules = var.website_routing_rules
}
