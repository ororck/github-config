resource "github_repository" "this" {
  name        = var.name
  description = var.description
  topics      = var.topics

  # Public is mandatory, rulesets are not available on private repositories
  # with this plan.
  visibility = "public"
  auto_init  = true

  has_wiki     = false
  has_projects = false

  # Merge commits only, so the branch history stays readable in review.
  allow_merge_commit     = true
  allow_squash_merge     = false
  allow_rebase_merge     = false
  delete_branch_on_merge = true
}

resource "github_repository_vulnerability_alerts" "this" {
  repository = github_repository.this.name
}

resource "github_repository_ruleset" "default_branch" {
  name        = "protect-default-branch"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = "active"

  # No bypass_actors block on purpose, the account admin is bound by the
  # rules too.

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = var.required_approving_review_count
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_review_thread_resolution = true
    }
  }
}
