variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "create_vpn_gateway" {
  description = "Controls if a VPN gateway will be created"
  default     = 0
}

variable "zones" {
  description = "The zones to create subnets in (us-south-1)"
  default     = []
}

variable "prefixes" {
  description = "Each zone defined requires it's own CIDR that will include the public, private and data subnets"
  default     = []
}

variable "public_subnets" {
  description = "CIDR ranges for the public layer subnets"
  default     = []
}

variable "private_subnets" {
  description = "CIDR ranges for the private layer subnets"
  default     = []
}

variable "data_subnets" {
  description = "CIDR ranges for the data layer subnets"
  default     = []
}
