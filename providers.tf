# Owner is a personal account, not an organization.
# Token comes from the GITHUB_TOKEN environment variable.
provider "github" {
  owner = var.github_owner
}

variable "github_owner" {
  description = "GitHub account that owns the repositories"
  type        = string
  default     = "ororck"
}
