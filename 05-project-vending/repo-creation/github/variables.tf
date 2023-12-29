variable "teams" {
  description = "(Optional) - This input variable contains GitHub teams attributes"
  type = map(object({
    privacy                   = string
    parent_team_name          = string
    description               = optional(string)
    ldap_dn                   = optional(string)
    create_default_maintainer = string
  }))

  default = {}
}

variable "repositories" {
  description = "(Optional) - This input variable contains GitHub repositories attributes"
  type = map(object({
    description                             = optional(string)
    visibility                              = optional(string)
    homepage_url                            = optional(string)
    has_projects                            = optional(bool)
    has_issues                              = optional(bool)
    has_wiki                                = optional(bool)
    is_template                             = optional(bool)
    allow_merge_commit                      = optional(bool)
    allow_squash_merge                      = optional(bool)
    allow_rebase_merge                      = optional(bool)
    allow_auto_merge                        = optional(bool)
    delete_branch_on_merge                  = optional(bool)
    has_downloads                           = optional(bool)
    gitignore_template                      = optional(string)
    license_template                        = optional(string)
    archived                                = optional(bool)
    archived_on_destroy                     = optional(bool)
    topics                                  = optional(list(string))
    vulnerability_alert                     = optional(bool)
    ignore_vulnerability_alerts_during_read = optional(bool)
    team                                    = string
    default_branch                          = optional(string)
    auto_init                               = optional(bool)
    permission                              = optional(string)
    # pages = optional(set(object({
    #   cname = optional(string)
    #   source = optional(set(object({
    #     branch = optional(string)
    #     path   = optional(string)
    #   })))
    # })))
    # template = optional(set(object({
    #   owner      = optional(string)
    #   repository = optional(string)
    # })))

    # environments = optional(map(object({
    #   wait_timer = string
    #   reviewers  = optional(set(object({
    #     users = optional(list(string))
    #     teams = optional(list(string))
    #   })))
    #   deployment_branch_policy = optional(set(object({
    #     protected_branches     = optional(bool)
    #     custom_branch_policies = optional(bool)
    #   })))
    # })))

    # labels = optional(map(object({
    #   color       = string
    #   description = string
    #   url         = optional(string)
    # })))
  }))

  default = {}
}

# variable "team_members" {
#   type = map(object({
#     role = string
#     team = string
#   }))

#   default = null
# }

# variable "org_member_invitation" {
#   type = map(object({
#     role = string
#   }))
#   default = {}
# }

# variable "branch_protection" {
#   description = "(Required) - this input variable contains the branch name"
#   type = map(object({
#     branch                          = list(string)
#     require_signed_commits          = bool
#     enforce_admins                  = bool
#     require_conversation_resolution = bool
#     required_pull_request_reviews = set(object({
#       dismiss_stale_reviews           = optional(bool)
#       dismissal_teams                 = optional(set(string))
#       dismissal_users                 = optional(set(string))
#       include_admins                  = optional(bool)
#       require_code_owner_reviews      = optional(bool)
#       required_approving_review_count = optional(number)
#     }))
#     required_status_checks = set(object({
#       contexts       = optional(set(string))
#       include_admins = optional(bool)
#       strict         = optional(bool)
#     }))
#     restrictions = set(object({
#       apps  = optional(set(string))
#       teams = optional(set(string))
#       users = optional(set(string))
#     }))
#   }))

#   default = {}
# }

variable "github_username" {
  description = "GitHub username for the collaborator"
}

variable "github_pat_token" {
  description = "GitHub token for the provider"
  type        = string
  sensitive   = true
}
