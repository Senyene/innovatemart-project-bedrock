output "developer_access_key_id" {
  value = module.developer_access.access_key_id
}

output "developer_secret_access_key" {
  value     = module.developer_access.secret_access_key
  sensitive = true
}

output "developer_iam_arn" {
  value = module.developer_access.developer_arn
}
