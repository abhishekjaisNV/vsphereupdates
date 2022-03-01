#define vpc
provider "vsphere" {
  user                 = "automation@vsphere.local"
  password             = "7v^S32,vxd5h'[+g"
  vsphere_server       = "10.206.5.41"
  allow_unverified_ssl = true
}
# If you have a self-signed cert

#### RETRIEVE DATA INFORMATION ON VCENTER ####

data "vsphere_datacenter" "dc" {
  name = "ISC"
}

data "vsphere_datastore" "datastore" {
  name          = "DS01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "10.206.2.155/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "Terraformtemp1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "iso_datastore" {
  name          = "DS01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "terraformtestvm" {
  count            = 2
  name             = "CloneVMtemp1"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus                   = 2
  memory                     = 2048
  guest_id                   = data.vsphere_virtual_machine.template.guest_id
  wait_for_guest_net_timeout = 0
  scsi_type                  = data.vsphere_virtual_machine.template.scsi_type
  firmware                   = "efi"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  cdrom {
    datastore_id = data.vsphere_datastore.iso_datastore.id
    path         = "DS01 / SW_DVD9_Win_Server_STD_CORE_2016_64Bit_English_-4_DC_STD_MLF_X21-70526(2).ISO"
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {


      windows_options {
        computer_name  = "terraform-test"
        admin_password = "12345678"
      }

      network_interface {
        ipv4_address = "10.0.0.10"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.0.0.1"
    }
  }
}
/*  network_interface {
      ipv4_address = "10.0.0.10"
      ipv4_netmask = 24
    }

    ip
  }
}

/*
data "vsphere_datacenter" "dc" {
  name = "10.206.2.155"
}



data "vsphere_datastore" "datastore" {
  name          = "DS01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "iso_datastore" {
  name          = "DS01"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
name = "Esx03.newvisionsoftware.com"
datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "resourcestest"
  datacenter_id = data.vsphere_datacenter.dc.id
}



data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "TESTVM"
  datacenter_id = data.vsphere_datacenter.dc.id
}


# Build 2012 R2 variable-map

resource "vsphere_virtual_machine" "New-VM2" {
  name             = "NewVM1"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id


  num_cpus                   = 2
  memory                     = 2048
  wait_for_guest_net_timeout = 0
  scsi_type                  = "lsilogic-sas"
  #nested_hv_enabled = true
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "e1000"
  }

  cdrom {
    datastore_id = data.vsphere_datastore.iso_datastore.id
    path         = DS01 / SW_DVD9_Win_Server_STD_CORE_2016_64Bit_English_-4_DC_STD_MLF_X21-70526(2).ISO
  }

  disk {
    size             = 30
    label            = "disk0"
    eagerly_scrub    = false
    thin_provisioned = true
  }
}

/*
clone {
  template_uuid = data.vsphere_virtual_machine.template.id
}


cdrom {
  datastore_id = data.vsphere_datastore.iso_datastore.id
  path         = DS01 / SW_DVD9_Win_Server_STD_CORE_2016_64Bit_English_-4_DC_STD_MLF_X21-70526(2).ISO
}

data "vsphere_datacenter" "demodata" {
  name = "vSpheredemo Datacenter"
}

data "vsphere_resource_pool" "pool" {
  name          = "vSpheredemo Cluster/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}


# Retrieve datastore information on vsphere
data "vsphere_datastore" "datastore" {
  name          = "vSpheredemoDatastore"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name          = "VM_Network-DPortGroup"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name          = "centos-8"
  datacenter_id = data.vsphere_datacenter.dc.id
}

#### VM CREATION ####

# Set vm parameters
resource "vsphere_virtual_machine" "demo1" {
  name             = "vm-one"
  num_cpus         = 1
  memory           = 1024
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  # Set network parameters
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Use a predefined vmware template as main disk
  disk {
    label = "vm-one.vmdk"
    size  = "30"
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "vm-one"
        domain    = "vm-one.homelab.local"
      }

      network_interface {
        ipv4_address    = "192.168.0.240"
        ipv4_netmask    = 24
        dns_server_list = ["192.168.0.120", "192.168.0.121"]
      }

      ipv4_gateway = "192.168.0.1"
    }
  }


  provisioner "remote-exec" {
    script = "scripts/example-script.sh"
    connection {
      type     = "ssh"
      user     = "root"
      password = "VMware1!"
      host     = vsphere_virtual_machine.demo.default_ip_address
    }
  }
}
*/
