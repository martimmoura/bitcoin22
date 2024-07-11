variable "cluster_arn" {
  description = "cluster arn to add permissions for ci role to describe cluster"
  type = string
  default = "arn:aws:eks:us-east-2:982065454085:cluster/bitcoin-eks-t2ZVZtAG"
}