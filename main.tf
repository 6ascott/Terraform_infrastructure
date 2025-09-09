#main.tf

#Resource Group 
resource "azurerm_resource_group" "rg" {
    #name of resource group 
    name = "Sample_Resource_Group"
    #location of resource group 
    location = "East US" 
}

