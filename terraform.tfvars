# resource
location = "East US 2"

# tag
prefix = "dev"

# azurerm_virtual_network
address_space = "10.0.0.0/16"

# azurerm_subnet
address_prefixes = "10.0.1.0/24"

# vmss
vm_size        = "Standard_B1s"
instances      = 3
admin_username = "adminuser"

#source_image_reference
publisher  = "Canonical"
offer      = "0001-com-ubuntu-server-focal"
sku        = "20_04-lts"
imgversion = "latest"

#os_disk
disk_caching         = "ReadWrite"
storage_account_type = "Standard_LRS"