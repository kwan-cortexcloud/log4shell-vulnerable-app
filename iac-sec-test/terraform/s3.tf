resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true
  tags = {
    git_commit           = "dae06248ba3414e47c2af7c6e7161244df4555f6"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 18:29:57"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "data"
    yor_trace            = "ed906ea0-ff3c-4f2f-83df-3a281979cd22"
  }
}

resource "aws_s3_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    git_commit           = "27e0ac7feb1e2a25798719edcde78acf016e060c"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 19:49:51"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "data_object"
    yor_trace            = "8dadf732-ba9b-44b2-9f88-535fa6864480"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  force_destroy = true
  tags = {
    git_commit           = "dae06248ba3414e47c2af7c6e7161244df4555f6"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 18:29:57"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "financials"
    yor_trace            = "a6b73f7d-3c3a-4711-a341-99a18d7701b5"
  }
}

resource "aws_s3_bucket_acl" "financials" {
  bucket = aws_s3_bucket.financials.id
  acl    = "private"
}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket        = "${local.resource_prefix.value}-operations"
  force_destroy = true
  tags = {
    git_commit           = "dae06248ba3414e47c2af7c6e7161244df4555f6"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 18:29:57"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "operations"
    yor_trace            = "983bcf5d-2e8b-4daf-89df-2087e96af6da"
  }
}

resource "aws_s3_bucket_acl" "operations" {
  bucket = aws_s3_bucket.operations.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_operations" {
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket        = "${local.resource_prefix.value}-data-science"
  force_destroy = true
  tags = {
    git_commit           = "dae06248ba3414e47c2af7c6e7161244df4555f6"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 18:29:57"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "data_science"
    yor_trace            = "0c22b726-4e0e-4de2-983b-3574a7e9db41"
  }
}

resource "aws_s3_bucket_acl" "data_science" {
  bucket = aws_s3_bucket.data_science.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_data_science" {
  bucket = aws_s3_bucket.data_science.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "data_science" {
  bucket = aws_s3_bucket.data_science.id

  target_bucket = "${aws_s3_bucket.logs.id}"
  target_prefix = "log/"
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${local.resource_prefix.value}-logs"
  force_destroy = true
  tags = {
    git_commit           = "dae06248ba3414e47c2af7c6e7161244df4555f6"
    git_file             = "code/iac/deployment_s3.tf"
    git_last_modified_at = "2025-01-03 18:29:57"
    git_last_modified_by = "kwan@paloaltonetworks.com"
    git_modifiers        = "kwan"
    git_org              = "kwan-prismacloud"
    git_repo             = "prisma-cloud-app-sec-workshop"
    yor_name             = "logs"
    yor_trace            = "9e4f9905-37ba-4e5b-a24a-a617ea35149a"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      sse_algorithm     = "aws:kms"
    }
  }
}