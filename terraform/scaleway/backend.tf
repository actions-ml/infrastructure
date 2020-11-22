terraform {
  backend "s3" {
    bucket                      = "actions-ml-infrastructure"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    iam_endpoint                = "https://s3.fr-par.scw.cloud"
    key                         = "scaleway.tfstate"
    region                      = "fr-par"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}
