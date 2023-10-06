terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
       prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "cosmos-db-rg" {
  name     = var.cosmos_db_rg
  location = var.location
}

resource "azurerm_cosmosdb_account" "cosmos-db-account" {
  name                = var.cosmos_db_account
  location            = azurerm_resource_group.cosmos-db-rg.location
  resource_group_name = azurerm_resource_group.cosmos-db-rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_automatic_failover = false
  geo_location {
    location          = var.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    azurerm_resource_group.cosmos-db-rg
  ]
}  

output "COSMOSDB_ENDPOINT" {
  description = "The endpoint of the CosmosDB Account"
  value       = azurerm_cosmosdb_account.cosmos-db-account.endpoint
}

output "COSMOSDB_PRIMARY_MASTER_KEY" {
  description = "The primary master key of the CosmosDB Account"
  value       = azurerm_cosmosdb_account.cosmos-db-account.primary_key
  sensitive   = true
}
