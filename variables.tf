variable "github_owner" {
  type        = string
  description = "GitHub organization or user that owns the repository."
}

variable "repository_name" {
  type        = string
  description = "Repository name that hosts the application project."
}

variable "visibility" {
  type        = string
  description = "Repository visibility."
  default     = "private"
}

variable "enable_ci_cd" {
  type        = bool
  description = "Whether to manage CI/CD settings for the repository."
  default     = true
}
