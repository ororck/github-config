variable "name" {
  description = "Repository name, case sensitive"
  type        = string
}

variable "description" {
  description = "Repository description"
  type        = string
}

variable "topics" {
  description = "Repository topics"
  type        = list(string)
  default     = []
}

variable "required_approving_review_count" {
  description = "Approvals needed before merge, 0 keeps the pull request mandatory without self approval"
  type        = number
  default     = 0
}
