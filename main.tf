provider "github" {
  owner = var.github_owner
}

resource "github_repository" "app_repo" {
  name        = var.repository_name
  visibility  = var.visibility
  auto_init   = true
  description = "Application repository managed by Terraform."
}

resource "github_actions_repository_permissions" "ci_cd" {
  count      = var.enable_ci_cd ? 1 : 0
  repository = github_repository.app_repo.name

  enabled         = true
  allowed_actions = "all"
}

resource "github_repository_file" "ci_workflow" {
  count      = var.enable_ci_cd ? 1 : 0
  repository = github_repository.app_repo.name
  file       = ".github/workflows/ci.yml"
  content    = <<-YAML
    name: CI

    on:
      push:
        branches: [ "main" ]
      pull_request:
        branches: [ "main" ]

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v4
          - name: Use Node.js
            uses: actions/setup-node@v4
            with:
              node-version: 20
          - name: Install
            run: npm install
          - name: Build
            run: npm run build
          - name: Test
            run: npm test --if-present
    YAML
  commit_message      = "Add CI workflow"
  overwrite_on_create = true
}
