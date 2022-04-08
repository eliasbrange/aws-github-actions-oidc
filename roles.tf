module "pull_request_role" {
  source = "./oidc-role"

  name = "gh-oidc-pull-request-role"
  subject_claims = [
    "repo:eliasbrange/aws-github-actions-oidc:pull_request"
  ]
  oidc_provider_arn = data.aws_iam_openid_connect_provider.github.arn
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : [
          aws_s3_bucket.dev_env_bucket.arn,
          aws_s3_bucket.prod_env_bucket.arn,
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
        ],
        "Resource" : [
          "${aws_s3_bucket.dev_env_bucket.arn}/*",
          "${aws_s3_bucket.prod_env_bucket.arn}/*",
        ]
      }
    ]
  })
}
