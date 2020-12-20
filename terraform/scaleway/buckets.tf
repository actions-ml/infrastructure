locals {
  object_buckets = [
    "actions-ml-infrastructure",
    "cache.actions-ml.org",
  ]
}

resource "scaleway_object_bucket" "object_buckets" {
  for_each = toset(local.object_buckets)

  name   = each.key
  acl    = "private"
  region = "fr-par"
}
