locals {
  object_buckets = {
    actions-ml-infrastructure = {
      acl = "private"
    }
  }
}

resource "scaleway_object_bucket" "object_buckets" {
  for_each = local.object_buckets

  name   = each.key
  acl    = each.value.acl
  region = "fr-par"
}
