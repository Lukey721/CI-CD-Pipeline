# Resource Group
resource "azurerm_resource_group" "terraform_rg" {
  name     = "my-terraform-resource-group"
  location = "North Europe"
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "tf-acr" {
  name                = "luketerraformacr"
  resource_group_name = azurerm_resource_group.terraform_rg.name
  location            = azurerm_resource_group.terraform_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# App Service Plan
resource "azurerm_app_service_plan" "app_plan" {
  name                = "terraform-app-service-plan"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

# Web App for Containers
resource "azurerm_linux_web_app" "webapp" {
  name                = "terraform-ruby-web-app"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  service_plan_id     = azurerm_app_service_plan.app_plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name        = "${var.container_name}:latest"
      docker_registry_url      = "https://${azurerm_container_registry.tf-acr.login_server}"
      docker_registry_username = azurerm_container_registry.tf-acr.admin_username
      docker_registry_password = azurerm_container_registry.tf-acr.admin_password
    }
  }
}