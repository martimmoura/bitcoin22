data "aws_caller_identity" "this" {}

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


data "aws_iam_policy_document" "assume_role_policy_prod-ci" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [aws_iam_role.prod-ci.arn]
  }
}


# creates policy and attaches policy to group
resource "aws_iam_group_policy" "prod-ci" {
    name  = "prod-ci"
    group = aws_iam_group.prod-ci.name
  
    policy = data.aws_iam_policy_document.assume_role_policy_prod-ci.json
}


