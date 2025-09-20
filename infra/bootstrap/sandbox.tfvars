tags = {
  Project         = "k8s-task"
  Environment     = "SANDBOX"
  ManagedBy       = "alytaha46@gmail.com"
}

############################################
################ General ###################
############################################
project_name = "k8s-task"
env          = "SANDBOX"


s3_bucket_name          = "k8s-task-terraform-s3-bucket"
dynamodb_table_name     = "k8s-task-dynamodb-state-locking"
dynamodb_hash_key       = "LockID"
dynamodb_hash_key_name  = "LockID"
dynamodb_hash_key_type  = "S"