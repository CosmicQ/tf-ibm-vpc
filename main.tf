resource ibm_is_vpc "vpc" {
  name            = "${var.name}-vpc"
}

resource "ibm_is_vpn_gateway" "vpn_gateway" {
  count           = "${var.create_vpn_gateway}"
  name            = "${var.name}-vpn-gateway"
  subnet          = "${ibm_is_subnet.public_subnet.0.id}"
}

resource "ibm_is_vpc_address_prefix" "prefix" {
  count           = "${length(var.prefixes)}"
  name            = "${var.name}-prefix-${count.index + 1}"
  zone            = "${var.zones[count.index]}"
  vpc             = "${ibm_is_vpc.vpc.id}"
  cidr            = "${var.prefixes[count.index]}"
}

resource "ibm_is_public_gateway" "gate" {
  count           = "${length(var.public_subnets)}"
  name            = "${var.name}-gate-${count.index +1}"
  zone            = "${var.zones[count.index]}"
  vpc             = "${ibm_is_vpc.vpc.id}"
}

resource ibm_is_subnet "public_subnet" {  
  count           = "${length(var.public_subnets)}"
  name            = "${var.name}-public-${count.index +1}"
  zone            = "${var.zones[count.index]}"
  vpc             = "${ibm_is_vpc.vpc.id}"
  public_gateway  = "${element(ibm_is_public_gateway.gate.*.id, count.index)}"
  ipv4_cidr_block = "${var.public_subnets[count.index]}"
}

resource ibm_is_subnet "private_subnet" {
  count           = "${length(var.private_subnets)}"
  name            = "${var.name}-private-${count.index +1}"
  zone            = "${var.zones[count.index]}"
  vpc             = "${ibm_is_vpc.vpc.id}"
  public_gateway  = "${element(ibm_is_public_gateway.gate.*.id, count.index)}"
  ipv4_cidr_block = "${var.private_subnets[count.index]}"
}

resource ibm_is_subnet "data_subnet" {
  count           = "${length(var.data_subnets)}"
  name            = "${var.name}-data-${count.index +1}"
  zone            = "${var.zones[count.index]}"
  vpc             = "${ibm_is_vpc.vpc.id}"
  public_gateway  = "${element(ibm_is_public_gateway.gate.*.id, count.index)}"
  ipv4_cidr_block = "${var.data_subnets[count.index]}"
}