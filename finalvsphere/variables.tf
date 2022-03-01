variable "vsphere_server" {
  description = "10.206.5.41"
  default     = "10.206.5.41"
}
variable "vsphere_user" {
  description = "automation@vsphere.local"
  default     = "automation@vsphere.local"
}
variable "vsphere_password" {
  description = "7v^S32,vxd5h'[+g"
  default     = "7v^S32,vxd5h'[+g"
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
  default = "Clone2VM"
}

# To set server parameter
variable "Server_parameter" {
  default = {
    hostname       = "Webapps2"
    for_each       = "12"
    vcpu           = "2"
    ram            = "2048"
    disk_size      = "30"
    firmware       = "efi"
    admin_password = "12345"
  }
}
