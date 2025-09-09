# virtual network
resource "azurerm_virtual_network" "vnet" {
    name = "Sample-vnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
} 

#subnet1
resource "azurerm_subnet" "subnet1" {
    name = "web-subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.2.0/24"]
}

#NIC (static ip for the webapp vm)
resource "azurerm_network_interface" "nic" {
    name = "nic"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    ip_configuration {
      #ip configuration block 
      name = "internal1"
      subnet_id = azurerm_subnet.subnet1.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.0.2.5"
    
    }
  
}

#NIC (static ip for the webapp vm)
resource "azurerm_network_interface" "nic2" {
    name = "nic2"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    ip_configuration {
      #ip configuration block 
      name = "internal2"
      subnet_id = azurerm_subnet.subnet1.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.0.2.6"
    
    }
  
}


#subnet2
resource "azurerm_subnet" "subnet2" {
    name = "database-subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.3.0/24"]
}

#NIC (static ip for the webapp vm)
resource "azurerm_network_interface" "nic3" {
    name = "nic3"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    ip_configuration {
      #ip configuration block 
      name = "database_config"
      subnet_id = azurerm_subnet.subnet2.id
      private_ip_address_allocation = "Static"
      private_ip_address = "10.0.3.5"
    
    }
  
}

#public ip creation
resource "azurerm_public_ip" "lb_public_ip" {
    name                = "lb-public-ip"
    location            = "East US"  
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
  
}
#load balancer
resource "azurerm_lb" "lb" {
    name = "webapp-lb"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    sku = "Standard"

    frontend_ip_configuration {
      name = "frontend"
      public_ip_address_id = azurerm_public_ip.lb_public_ip.id
    }
 
}

#backend addresses
resource "azurerm_lb_backend_address_pool" "bepool" {
    loadbalancer_id = azurerm_lb.lb.id
    name = "webapp-backend-pool"
    
  
}

#This is for demo purposes
resource "azurerm_lb_probe" "lb_hprobe" {
    loadbalancer_id = azurerm_lb.lb.id
    name = "ssh-probe"
    port = 22
    protocol = "Tcp"
    interval_in_seconds = 10
    number_of_probes = 2

  
}

resource "azurerm_lb_rule" "ssh_rule" {
    loadbalancer_id = azurerm_lb.lb.id
    name = "ssh-rule"
    protocol = "Tcp"
    frontend_port = 22
    backend_port = 22
    frontend_ip_configuration_name = "frontend"
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.bepool.id] 

  
}
#adding back end pool vm1
resource "azurerm_network_interface_backend_address_pool_association" "vm1-allocate" {
    network_interface_id = azurerm_network_interface.nic.id
    ip_configuration_name = "internal1"
    backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
  
}
#adding back end pool vm2
resource "azurerm_network_interface_backend_address_pool_association" "vm2-allocation" {
    network_interface_id = azurerm_network_interface.nic2.id
    ip_configuration_name = "internal2"
    backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
  
}


