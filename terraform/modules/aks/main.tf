resource "azurerm_resource_group" "rg" {
  name     = "aks-rg"
  location = "westus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                 = "my-aks1988"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = "my-aks1988"
  azure_policy_enabled = true
  oidc_issuer_enabled  = true

  key_vault_secrets_provider {

    secret_rotation_enabled = true

  }

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2s_v3"
  }


  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

