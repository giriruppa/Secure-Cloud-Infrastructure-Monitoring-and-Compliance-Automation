############################################################
# Project: Secure Cloud Infrastructure Monitoring & Compliance
# Tools: Azure + Terraform + Puppet + Nagios
# Author: Ruppa Giridhar
# Location: Central India
# Changes you need to Vm passwords and connect your account to  Azure CLI
############################################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

############################################################
# 1️⃣ Resource Group
############################################################

resource "azurerm_resource_group" "puppet_rg" {
  name     = "PuppetProjectRG"
  location = "Central India"
}

############################################################
# 2️⃣ Virtual Network and Subnet
############################################################

resource "azurerm_virtual_network" "puppet_vnet" {
  name                = "vnet-centralindia"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name
}

resource "azurerm_subnet" "puppet_subnet" {
  name                 = "snet-centralindia-1"
  resource_group_name  = azurerm_resource_group.puppet_rg.name
  virtual_network_name = azurerm_virtual_network.puppet_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

############################################################
# 3️⃣ Public IP Addresses
############################################################

# Puppet + Nagios Server Public IP
resource "azurerm_public_ip" "puppet_public_ip" {
  name                = "puppet-nagios-ip"
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Puppet Agent VM Public IP
resource "azurerm_public_ip" "agent_public_ip" {
  name                = "puppet-agent-ip"
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


############################################################
# 4️⃣ Network Security Group and Rules
############################################################

resource "azurerm_network_security_group" "puppet_nsg" {
  name                = "puppet-nsg"
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name

  # Allow SSH (for access)
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  # Allow Nagios Web Port (HTTP)
  security_rule {
    name                       = "Allow-HTTP-Nagios"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  # Allow Puppet Communication (Port 8140)
  security_rule {
    name                       = "Allow-Puppet"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "8140"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

############################################################
# 5️⃣ Network Interfaces
############################################################

# Puppet Master + Nagios Interface
resource "azurerm_network_interface" "puppet_nic" {
  name                = "puppet-nagios-nic"
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.puppet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.puppet_public_ip.id
  }
}

# Puppet Agent Interface
resource "azurerm_network_interface" "agent_nic" {
  name                = "puppet-agent-nic"
  location            = azurerm_resource_group.puppet_rg.location
  resource_group_name = azurerm_resource_group.puppet_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.puppet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.agent_public_ip.id
  }
}

############################################################
# 6️⃣ Associate NSG with NICs
############################################################

resource "azurerm_network_interface_security_group_association" "puppet_nic_assoc" {
  network_interface_id      = azurerm_network_interface.puppet_nic.id
  network_security_group_id = azurerm_network_security_group.puppet_nsg.id
}

resource "azurerm_network_interface_security_group_association" "agent_nic_assoc" {
  network_interface_id      = azurerm_network_interface.agent_nic.id
  network_security_group_id = azurerm_network_security_group.puppet_nsg.id
}

############################################################
# 7️⃣ Virtual Machines
############################################################

# Puppet Master + Nagios VM
resource "azurerm_linux_virtual_machine" "puppet_master_vm" {
  name                = "PuppetMaster-Nagios"
  resource_group_name = azurerm_resource_group.puppet_rg.name
  location            = azurerm_resource_group.puppet_rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"
  admin_password      = " "  (Your Vm Password)
  network_interface_ids = [azurerm_network_interface.puppet_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  disable_password_authentication = false
}

# Puppet Agent VM
resource "azurerm_linux_virtual_machine" "puppet_agent_vm" {
  name                = "PuppetAgent-Node"
  resource_group_name = azurerm_resource_group.puppet_rg.name
  location            = azurerm_resource_group.puppet_rg.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "" ( (Your Vm Password))
  network_interface_ids = [azurerm_network_interface.agent_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  disable_password_authentication = false
}

############################################################
# 8️⃣ Output Public IPs
############################################################

output "puppet_nagios_public_ip" {
  description = "Public IP of the Puppet Master + Nagios Server"
  value       = azurerm_public_ip.puppet_public_ip.ip_address
}

output "puppet_agent_public_ip" {
  description = "Public IP of the Puppet Agent Node"
  value       = azurerm_public_ip.agent_public_ip.ip_address
}

