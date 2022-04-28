resource "aws_s3_bucket" "bucket" {

  bucket = local.bucket_name

}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
