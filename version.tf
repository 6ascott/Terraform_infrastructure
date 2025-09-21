terraform {
  #cloud provider  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
    subscription_id = "2bde2ba1-39c9-4093-9a0d-fe665768699b"
    features {
      
    }
  
}