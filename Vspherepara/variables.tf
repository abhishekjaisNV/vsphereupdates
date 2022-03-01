variable "vsphere_server" {
    description = "10.206.5.41"
    default = "10.206.5.41"
}
variable "vsphere_user" {
    description = "automation@vsphere.local"
    default = "automation@vsphere.local"
}
variable "vsphere_password" {
    description = "7v^S32,vxd5h'[+g"
    default = "7v^S32,vxd5h'[+g"
}


# Set Datacenter where you want deploy your vm
variable "dc" {
  default = "ISC"
}

# Set Resourcepool where you want deploy your vm
variable "pool" {
  default = "Resourcetest"
}

# Set Datastore where you want deploy your vm
variable "datastore" {
  default = "DS01"
}

# Set Network where you want deploy your vm
variable "network" {
  default = "VM Network"
}

# Set Templet where you want deploy your vm
variable "templet" {
  default = "Terraformtemp1"
}

# To set server parameter 
variable "Server_parameter" {
  default = {
    hostname       = "Terra1"
    count          = "10"
    vcpu           = "4"
    ram            = "4096"
    disk_size      = "15"
    firmware       = "efi"
    admin_password ="12345"
  }
  
}