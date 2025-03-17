terraform {
  backend "azurerm" {
    resource_group_name  = "my-terraform-resource-group"
    storage_account_name = "mytfstatestorageluke"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}