terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.78.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state"
    storage_account_name = "vg1988my"
    container_name       = "terraform"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true

  }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "aks" {
  source              = "./modules/aks"
  location            = var.location
  resource_group_name = var.resource_group_name
}
module "acr" {
  source              = "./modules/acr"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = module.aks.kubelet_object_id
  role_definition_name             = "AcrPull"
  scope                            = module.acr.acr_id
  skip_service_principal_aad_check = true
}
