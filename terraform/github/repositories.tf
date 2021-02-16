locals {
  github_repos = {
    infrastructure = {
      description = "Infrastructure configuration files"
      teams = [
        "actions-ops",
      ]
    }

    ".github" = {
      description = "actions-ml meta repository"
      teams = [
        "core",
      ]
    }

    actions = {
      description = "GitHub Actions for the OCaml programming language"
      teams = [
        "core",
      ]
    }

    cache-statistics = {
      description = "Web page for showing cache statistics"
      teams = [
        "core",
      ]
    }

    compiler-cache = {
      description = "Generate compiler binary caches for setup-ocaml"
      teams = [
        "core",
      ]
    }

    setup-ocaml = {
      description = "GitHub Action for the OCaml programming language"
      teams = [
        "core",
      ]
    }
  }
}

resource "github_repository" "repositories" {
  for_each = local.github_repos

  name                   = each.key
  description            = each.value.description
  homepage_url           = lookup(each.value, "homepage_url", null)
  topics                 = lookup(each.value, "topics", null)
  allow_rebase_merge     = false
  allow_squash_merge     = false
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = false
  has_wiki               = false
}

resource "github_team_repository" "team_repositories" {
  for_each = { for i in flatten([for repo_name, repo in local.github_repos :
    [for team_name in repo.teams : {
      repo_name = repo_name, team_name = team_name
    }]
  ]) : format("%s.%s", i.repo_name, i.team_name) => i }

  team_id    = github_team.teams[each.value.team_name].id
  repository = github_repository.repositories[each.value.repo_name].name
  permission = "push"
}
