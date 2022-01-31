resource "azurerm_monitor_autoscale_setting" "default"{
    name = "${var.resource_prefix}-defaultMonitoring"
    resource_group_name = azurerm_resource_group.azure_rg.name
    location = azurerm_resource_group.azure_rg.location
    target_resource_id = azurerm_virtual_machine_scale_set.scale_set.id

profile {
    name = "defaultprofile"
    capacity {
        default = 2
        minimum = 2
        maximum = 5
    }
rule {
    metric_trigger {
      metric_name = "Percentage CPU"
      metric_resource_id = azurerm_virtual_machine_scale_set.scale_set.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT5M"
      time_aggregation = "Average"
      operator = "GreaterThan"
      threshold = 75
      metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
    }
    scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_virtual_machine_scale_set.scale_set.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["shubham.jind03@gmail.com"]
    }
}

}



