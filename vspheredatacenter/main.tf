#define vpc
provider "vsphere" {
  user                 = "automation@vsphere.local"
  password             = "7v^S32,vxd5h'[+g"
  vsphere_server       = "10.206.5.44"
  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "research_datacenter" {
  name   = "my_research_datacenter"
  folder = "/research/"
}
