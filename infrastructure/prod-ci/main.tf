data "aws_caller_identity" "this" {}

locals {
  oidc_url="https://token.actions.githubusercontent.com"
}

data "tls_certificate" "openid_connector_thumbprint" {
  url = local.oidc_url
}

resource "aws_iam_openid_connect_provider" "github" {
    url = local.oidc_url

    client_id_list = [
        "sts.amazonaws.com",
    ]

    thumbprint_list = data.tls_certificate.openid_connector_thumbprint.certificates.*.sha1_fingerprint
}

resource "aws_iam_role" "prod-ci" {
  name = "prod-ci"
  assume_role_policy = data.aws_iam_policy_document.trust_policy_prod-ci.json
}

data "aws_iam_policy_document" "trust_policy_prod-ci" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.this.account_id]
    }
  }

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:martimmoura/bitcoin22:*"
      ]
    }
  }
}

resource "aws_iam_user" "prod-ci" {
    name = "prod-ci"
    force_destroy = true
}

resource "aws_iam_group" "prod-ci" {
    name = "prod-ci"
}

resource "aws_iam_group_membership" "team" {
    name = "prod-ci"
    group = aws_iam_group.prod-ci.name

    users = [
        aws_iam_user.prod-ci.name
    ]
}

#policy doc for assuming prod-ci role
data "aws_iam_policy_document" "assume_role_policy_prod-ci" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [aws_iam_role.prod-ci.arn]
  }

}

# creates policy and attaches to group
resource "aws_iam_group_policy" "prod-ci" {
    name  = "prod-ci"
    group = aws_iam_group.prod-ci.name
  
    policy = data.aws_iam_policy_document.assume_role_policy_prod-ci.json
}


