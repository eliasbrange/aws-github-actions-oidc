module "pull_request_role" {
  source = "./oidc-role"

  name = "gh-oidc-pull-request-role"
  subject_claims = [
    "repo:eliasbrange/aws-github-actions-oidc:pull_request",
    "repo:eliasbrange/aws-github-actions-oidc:ref:refs/heads/main"
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

module "main_branch_role" {
  source = "./oidc-role"

  name = "gh-oidc-main-branch-role"
  subject_claims = [
    "repo:eliasbrange/aws-github-actions-oidc:ref:refs/heads/main"
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
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
        ],
        "Resource" : [
          "${aws_s3_bucket.dev_env_bucket.arn}/*",
        ]
      }
    ]
  })
}

module "prod_env_role" {
  source = "./oidc-role"

  name = "gh-oidc-prod-env-role"
  subject_claims = [
    "repo:eliasbrange/aws-github-actions-oidc:environment:Production"
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
          aws_s3_bucket.prod_env_bucket.arn,
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
        ],
        "Resource" : [
          "${aws_s3_bucket.prod_env_bucket.arn}/*",
        ]
      }
    ]
  })
}
