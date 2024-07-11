# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}


variable "isOn" {
  type = bool
  default = true
}

variable "ci_role_arn"{
  type = string
  default = "arn:aws:iam::982065454085:role/prod-ci"
}