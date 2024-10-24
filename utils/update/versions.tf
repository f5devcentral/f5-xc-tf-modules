terraform {
  required_version = ">= 1.7.0"

  required_providers {
    restful = {
      source  = "magodo/restful"
      version = ">= 0.16.1"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}