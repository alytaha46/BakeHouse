terraform {
    backend "s3" {
    bucket              = "k8s-task-terraform-s3-bucket"
    key                 = "terraform.tfstate"
    region         	    = "eu-west-1"
    dynamodb_table      = "k8s-task-dynamodb-state-locking"
  }
}