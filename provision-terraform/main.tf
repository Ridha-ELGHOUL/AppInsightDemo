resource "azurerm_resource_group" "appinsightdemo" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "appinsightdemo" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.appinsightdemo.location
  resource_group_name = azurerm_resource_group.appinsightdemo.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appinsightdemo" {
  name                = var.app_service_name
  location            = azurerm_resource_group.appinsightdemo.location
  resource_group_name = azurerm_resource_group.appinsightdemo.name
  app_service_plan_id = azurerm_app_service_plan.appinsightdemo.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

}
resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "workspace-test"
  location            = azurerm_resource_group.appinsightdemo.location
  resource_group_name = azurerm_resource_group.appinsightdemo.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_application_insights" "appinsight" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.appinsightdemo.location
  resource_group_name = azurerm_resource_group.appinsightdemo.name
  workspace_id        = azurerm_log_analytics_workspace.loganalytics.id
  application_type    = "web"
}