#████████╗███████╗██████╗ ██████╗  █████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗    ██████╗  ██████╗ ██╗  ██╗
#╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║    ██╔══██╗██╔═══██╗╚██╗██╔╝
#   ██║   █████╗  ██████╔╝██████╔╝███████║█████╗  ██║   ██║██████╔╝██╔████╔██║    ██████╔╝██║   ██║ ╚███╔╝ 
#   ██║   ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║    ██╔══██╗██║   ██║ ██╔██╗ 
#   ██║   ███████╗██║  ██║██║  ██║██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║    ██████╔╝╚██████╔╝██╔╝ ██╗
#   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

variable my_aws_region {
  default = "us-east-1"
}

variable ec2_image_id {
  default = "ami-03d315ad33b9d49c4"
}

variable ec2_key_name {
  default = "id_rsa.pub"
}

variable ec2_key_filename {
  default = "New_Pair_Mac.pem"
}

variable "my_ip_addresses" {
  description = "My allowed IP addresses"
  type        = list(string)
  default     = ["38.88.104.139/32"]
}

variable "zabbix_access_allowed_ip_addresses" {
  description = "The IP addressess that are allowed to access my Zabbix service interface"
  type        = list(string)
  default     = ["38.88.104.139/32"] # example: 0.0.0.0/0
}

variable "zabbix_service_allowed_ip_addresses" {
  description = "The IP addressess that are allowed to send data to my Zabbix service"
  type        = list(string)
  default     = ["38.88.104.139/32"] # example: 0.0.0.0/0
}
