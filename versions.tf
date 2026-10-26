terraform {
  required_version = ">= 1.9"

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateororck"
    container_name       = "tfstate"
    key                  = "github-config.tfstate"
    subscription_id      = "8dd13e6d-a7fa-44c3-82fd-513fd2171e4a"
    use_azuread_auth     = true
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
