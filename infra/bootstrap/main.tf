module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws" 
  bucket = var.s3_bucket_name
  versioning = {
    enabled = true
  }
  tags = var.tags
}


resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table_name
  tags           = var.tags
  read_capacity  = 1
  write_capacity = 1
  hash_key       = var.dynamodb_hash_key

  attribute {
    name = var.dynamodb_hash_key_name
    type = var.dynamodb_hash_key_type
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.enforce_https.json
}

data "aws_iam_policy_document" "enforce_https" {

  version = "2012-10-17"
  statement {
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false",
      ]
    }

    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values = [
        "1.2",
      ]
    }
  }

}
