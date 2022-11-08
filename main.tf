# Create a VPC
resource "huaweicloud_vpc" "this" {
  name = "${var.name}-cce-vpc"
  cidr = var.vpc_cidr
}

# Create subnet
resource "huaweicloud_vpc_subnet" "this" {
  name       = "${var.name}-subnet"
  cidr       = var.cce_subnet_cidr
  gateway_ip = var.cce_gateway_ip

  //dns is required for cce node installing
  primary_dns   = var.dns.primary_dns
  secondary_dns = var.dns.secondary_dns
  vpc_id        = huaweicloud_vpc.this.id
}

resource "huaweicloud_cce_cluster" "this" {
  name                   = "${var.name}-cluster"
  flavor_id              = "cce.s1.small"
  vpc_id                 = huaweicloud_vpc.this.id
  subnet_id              = huaweicloud_vpc_subnet.this.id
  container_network_type = "overlay_l2"
}

data "huaweicloud_availability_zones" "az" {}

resource "huaweicloud_compute_keypair" "this" {
  name       = "${var.name}-keypair"
  public_key = file("${path.module}/cce.pub")
}

resource "huaweicloud_cce_node" "node" {
  count             = var.num_node
  cluster_id        = huaweicloud_cce_cluster.this.id
  name              = "${var.name}-node-0${count.index}"
  flavor_id         = "s3.large.2"
  availability_zone = data.huaweicloud_availability_zones.az.names[0]
  key_pair          = huaweicloud_compute_keypair.this.name

  root_volume {
    size       = 40
    volumetype = "SATA"
  }
  data_volumes {
    size       = 100
    volumetype = "SATA"
  }
}
