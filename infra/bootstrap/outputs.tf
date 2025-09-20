output "s3_bucket" {
  value = module.s3_bucket.s3_bucket_id
}

output "dynamodb" {
  value = aws_dynamodb_table.terraform_state_lock.name
}
