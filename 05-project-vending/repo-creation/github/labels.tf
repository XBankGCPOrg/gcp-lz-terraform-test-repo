# locals {
#   repos_with_labels = { for k, v in var.repositories : k => v if v.labels != null }
#   labels_map = merge([
#     for root_id, values in local.repos_with_labels:
#     { 
#       for label_id, label in values.labels:
#         "${root_id}-${label_id}" => {
#           repository  = root_id
#           name        = label_id
#           color       = label.color
#           description = label.description
#       }
#     } 
#   ]...)
# }

# resource "github_issue_label" "default" {
#   for_each    = local.labels_map
#   repository  = each.value.repository
#   name        = each.value.name
#   color       = each.value.color
#   description = each.value.description
# }
