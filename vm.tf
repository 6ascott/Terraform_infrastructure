#webapp1 (VM configuration)
resource "azurerm_linux_virtual_machine" "vm" {
    name = "webapp1-vm"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    size = "Standard_B1s"
    admin_username = "adminuser"
    
    admin_ssh_key {
        username = "adminuser"
        #default public key path 
        public_key = file("~/.ssh/id_rsa.pub")
      
    }
    
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }

    
}

#webapp2(VM )
resource "azurerm_linux_virtual_machine" "vm2" {
    name = "webapp1-vm2"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic2.id]
    size = "Standard_B1s"
    admin_username = "adminuser"
    
    admin_ssh_key {
        username = "adminuser"
        #default public key path 
        public_key = file("~/.ssh/id_rsa.pub")
      
    }
    
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }

    
}

#Database Vm (VM configuration)
resource "azurerm_linux_virtual_machine" "vm3" {
    name = "database-vm3"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic3.id]
    size = "Standard_B1s"
    admin_username = "adminuser"
    
    admin_ssh_key {
        username = "adminuser"
        #default public key path 
        public_key = file("~/.ssh/id_rsa.pub")
      
    }
    
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }

    
}
