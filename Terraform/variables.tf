variable "cosmosdb_nosqldb_name"{
  type        = string
  default     = "cosmosdb-nosqldb"
  description = "cosmosdb nosql database"
}

variable "cosmos_db_rg" {
    type = string
    default = "abhi-cosmos-db-rg"
    description = "cosmos db resource group"
}

variable "location" {
    type = string
    default = "East US"
    description = "location for resource group"
}

variable "cosmos_db_account" {
    type = string
    default = "abhi-cosmos-db-account"
    description = "cosmos db account"
}

variable "nosql_container_name" {
    type = string
    default = "abhi-nosql-container"
    description = "cosmos db container"
}

