locals {
  data_inputs = {
    html_data = var.html_data
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_prefixes]
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "${var.prefix}-vmss"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.vm_size
  instances           = var.instances
  admin_username      = var.admin_username
  user_data           = base64encode(templatefile("userdata.tftpl", local.data_inputs))
  health_probe_id     = azurerm_lb_probe.lb_probe.id

  admin_ssh_key {
    username = var.admin_username
    #public_key = local.first_public_key
    public_key = file("id_rsa.pub")
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.imgversion
  }

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  network_interface {
    name    = "${var.prefix}-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backpool.id]
    }
  }

  automatic_instance_repair {
    enabled      = true
    grace_period = "PT10M"
  }
}

# resource "azurerm_monitor_autoscale_setting" "main" {
#   name                = "autoscale-config"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

#   profile {
#     name = "AutoScale"

#     capacity {
#       default = 2
#       minimum = 1
#       maximum = 3
#     }

#     rule {
#       metric_trigger {
#         metric_name        = "Percentage CPU"
#         metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT5M"
#         time_aggregation   = "Average"
#         operator           = "GreaterThan"
#         threshold          = 75
#       }

#       scale_action {
#         direction = "Increase"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }

#     rule {
#       metric_trigger {
#         metric_name        = "Percentage CPU"
#         metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT5M"
#         time_aggregation   = "Average"
#         operator           = "LessThan"
#         threshold          = 25
#       }

#       scale_action {
#         direction = "Decrease"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT1M"
#       }
#     }
#   }
# }
