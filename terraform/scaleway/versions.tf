terraform {
  required_version = ">= 0.13"

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "2.0.0"
    }

    scaleway = {
      source  = "scaleway/scaleway"
      version = "1.17.2"
    }
  }
}
