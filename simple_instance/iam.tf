# grant EC2 iam profile to access bucket
resource "aws_iam_role" "bianca_test" {
  name               = "web_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "BiancaTestAssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "bianca_test_profile" {
  name = "web_instance_profile"
  role = aws_iam_role.bianca_test.name
}

# Policy to access the bucket
resource "aws_iam_policy" "s3_access" {
  name = "${local.product_name}-s3-access"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${local.bucket_name}",
          "arn:aws:s3:::${local.bucket_name}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.bianca_test.name
  policy_arn = aws_iam_policy.s3_access.arn
}

# SSM
resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.bianca_test.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
