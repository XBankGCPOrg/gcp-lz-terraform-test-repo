# locals {
#   repos_with_environments = { for k, v in var.repositories : k => v if v.environments != null }
#   environments_map = merge([
#     for root_id, values in local.repos_with_environments:
#     { 
#       for env_id, envs in values.environments:
#         "${root_id}-${env_id}" => {
#           repository               = root_id
#           environment              = env_id
#           wait_timer               = envs.wait_timer
#           reviewers                = envs.reviewers
#           deployment_branch_policy = envs.deployment_branch_policy
#         }
#     } 
#   ]...)
# }

# resource "github_repository_environment" "default" {
#   for_each    = local.environments_map
#   repository  = each.value.repository
#   environment = each.value.environment
#   wait_timer  = each.value.wait_timer

#   dynamic "reviewers" {
#     for_each = each.value.reviewers
#       content {
#         users = reviewers.value["users"]
#         teams = [github_team.default[reviewers.value.teams[0]].id]
#       }
#   }

#   dynamic "deployment_branch_policy" {
#     for_each = each.value.deployment_branch_policy
#       content {
#         protected_branches     = deployment_branch_policy.value["protected_branches"]
#         custom_branch_policies = deployment_branch_policy.value["custom_branch_policies"]
#       }
#   }
# }
