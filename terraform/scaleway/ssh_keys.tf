locals {
  github_usernames = [
    "smorimoto",
  ]
}

data "http" "github_keys" {
  for_each = toset(local.github_usernames)

  url = format("https://github.com/%s.keys", each.key)
}

resource "scaleway_account_ssh_key" "ssh_keys" {
  for_each = { for idx, i in flatten([for username in local.github_usernames :
    [for idx, _line in
      compact(split("\n", data.http.github_keys[username].body)) :
      {
        name = username
        public_key = element(
          compact(split("\n", data.http.github_keys[username].body)),
          idx
        )
      }
  ]]) : format("%s.%d", i.name, idx) => i }

  name       = each.value.name
  public_key = each.value.public_key
}
