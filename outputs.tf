output "vpc_name" {
  description = "Name of the VPC"
  value       = "${var.name}-vpc"
}

output "vpc_id" {
  description = "VPC ID"
  value       = "${ibm_is_vpc.vpc.id}"
}

output "vpn_gateway_id" {
  description = "VPN gateway ID"
  value       = "${ibm_is_vpn_gateway.vpn_gateway.*.id}"
}

output "gateway_ids" {
  description = "List of gateway IDs"
  value       = ["${ibm_is_public_gateway.gate.*.id}"]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = ["${ibm_is_subnet.public_subnet.*.id}"]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = ["${ibm_is_subnet.private_subnet.*.id}"]
}

output "data_subnets_ids" {
  description = "List of data subnet IDs"
  value       = ["${ibm_is_subnet.data_subnet.*.id}"]
}