# locals {
#   branch_protection_data = yamldecode(file("${path.module}/project_vending.yaml"))
# }


# locals {
#   branch_map = merge([
#     for root_id, values in local.branch_protection_data.branch_protection :
#     {
#       for branch in values.branch :
#       "${root_id}-${branch}" => {
#         repository                      = root_id
#         branch                          = branch
#         enforce_admins                  = values.enforce_admins
#         require_signed_commits          = values.require_signed_commits
#         required_pull_request_reviews   = values.required_pull_request_reviews
#         require_conversation_resolution = values.require_conversation_resolution
#         required_status_checks          = values.required_status_checks
#         restrictions                    = values.restrictions
#       }
#     }
#   ]...)
# }


# resource "github_branch_protection" "default" {
#   for_each                        = local.branch_map
#   repository_id                   = each.value.repository
#   pattern                         = each.value.branch
#   enforce_admins                  = each.value.enforce_admins
#   require_signed_commits          = each.value.require_signed_commits
#   require_conversation_resolution = each.value.require_conversation_resolution

#   depends_on = [github_branch.default]
# }


# output "example_output" {
#   value = local.branch_map
# }

# resource "github_branch_protection_v3" "default" {
#   for_each                        = local.branch_map
#   branch                          = each.value.branch
#   repository                      = each.value.repository
#   enforce_admins                  = each.value.enforce_admins
#   require_signed_commits          = each.value.require_signed_commits
#   require_conversation_resolution = each.value.require_conversation_resolution

#   # dynamic "required_pull_request_reviews" {
#   #   for_each = each.value.required_pull_request_reviews
#   #   content {
#   #     dismiss_stale_reviews           = required_pull_request_reviews.value["dismiss_stale_reviews"]
#   #     dismissal_teams                 = required_pull_request_reviews.value["dismissal_teams"]
#   #     dismissal_users                 = required_pull_request_reviews.value["dismissal_users"]
#   #     include_admins                  = required_pull_request_reviews.value["include_admins"]
#   #     require_code_owner_reviews      = required_pull_request_reviews.value["require_code_owner_reviews"]
#   #     required_approving_review_count = required_pull_request_reviews.value["required_approving_review_count"]
#   #   }
#   # }

#   # dynamic "required_status_checks" {
#   #   for_each = each.value.required_status_checks
#   #   content {
#   #     contexts       = required_status_checks.value["contexts"]
#   #     include_admins = required_status_checks.value["include_admins"]
#   #     strict         = required_status_checks.value["strict"]
#   #   }
#   # }

#   # dynamic "restrictions" {
#   #   for_each = each.value.restrictions
#   #   content {
#   #     apps  = restrictions.value["apps"]
#   #     teams = restrictions.value["teams"]
#   #     users = restrictions.value["users"]
#   #   }
#   # }

#   depends_on = [github_branch.default]
# }
