#define vpc
provider "vsphere" {
  user                 = "automation@vsphere.local"
  password             = "7v^S32,vxd5h'[+g"
  vsphere_server       = "10.206.5.44"
  allow_unverified_ssl = true
}

variable "hosts" {
  default = [
    "esxi1",
    "esxi2",
    "esxi3",
  ]
}

data "vsphere_datacenter" "datacenter" {
  name = "CCDataCenter"
}

data "vsphere_host" "esxi_hosts" {
  count         = length(var.hosts)
  name          = var.hosts[count.index]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "terraform-datastore-cluster-test"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  sdrs_enabled  = true
}

resource "vsphere_nas_datastore" "datastore1" {
  name                 = "terraform-datastore-test1"
  host_system_ids      = ["${data.vsphere_host.esxi_hosts.*.id}"]
  datastore_cluster_id = vsphere_datastore_cluster.datastore_cluster.id

  type         = "NFS"
  remote_hosts = ["nfs"]
  remote_path  = "/export/terraform-test1"
}

resource "vsphere_nas_datastore" "datastore2" {
  name                 = "terraform-datastore-test2"
  host_system_ids      = ["${data.vsphere_host.esxi_hosts.*.id}"]
  datastore_cluster_id = vsphere_datastore_cluster.datastore_cluster.id

  type         = "NFS"
  remote_hosts = ["nfs"]
  remote_path  = "/export/terraform-test2"
}
