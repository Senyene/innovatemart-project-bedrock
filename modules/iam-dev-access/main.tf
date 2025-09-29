resource "aws_iam_user" "developer" {
  name = var.user_name
  tags = {
    Purpose = "EKS ReadOnly Access"
  }
}

resource "aws_iam_access_key" "developer" {
  user = aws_iam_user.developer.name
}

resource "aws_iam_policy" "eks_readonly" {
  name        = "EKSReadOnlyAccess"
  description = "Read-only access to EKS cluster"
  policy      = file("${path.module}/eks-readonly-policy.json")
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.developer.name
  policy_arn = aws_iam_policy.eks_readonly.arn
}

output "access_key_id" {
  value = aws_iam_access_key.developer.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.developer.secret
  sensitive = true
}

output "developer_arn" {
  value = aws_iam_user.developer.arn
}
