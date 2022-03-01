
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = true
}
#Data Sources
data "vsphere_datacenter" "dc" {
  name = var.dc
}

data "vsphere_resource_pool" "pool" {
  name          = var.pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve datastore information on vsphere
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name          = var.templet
  datacenter_id = data.vsphere_datacenter.dc.id
}
#Virtual Machine Resource
resource "vsphere_virtual_machine" "vmachine2" {
  count            = var.Server_parameter["count"]
  name             = "${var.Server_parameter["hostname"]}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.Server_parameter["vcpu"]
  memory           = var.Server_parameter["ram"]
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  firmware         = var.Server_parameter["firmware"]
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.Server_parameter["adapter_type"]
  }
  disk {
    label            = "${var.Server_parameter["hostname"]}.vmdk"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      windows_options {
        computer_name  = "${var.Server_parameter["hostname"]}-${count.index + 1}"
        admin_password = var.Server_parameter["admin_password"]

      }

      network_interface {
        ipv4_address = "10.0.0.${0 + count.index * 5}"
        ipv4_netmask = 24
      }
      ipv4_gateway = "10.0.0.1"

    }

  }
}
