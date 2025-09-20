variable "project_name" {
  type = string
}
variable "env" {
  type = string
}
variable "tags" {
  type        = map(any)
  description = "Map of Default Tags"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB table"
}

variable "dynamodb_hash_key_name" {
  description = "Hash key name for the DynamoDB table"
}

variable "dynamodb_hash_key_type" {
  description = "Hash key type for the DynamoDB table"
}