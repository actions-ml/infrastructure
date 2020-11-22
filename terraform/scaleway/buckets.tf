resource "scaleway_object_bucket" "object_bucket" {
  name   = "actions-ml-infrastructure"
  acl    = "private"
  region = "fr-par"
}
