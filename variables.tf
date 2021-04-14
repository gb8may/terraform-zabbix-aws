 ______   ______     ______     ______     ______     ______   ______     ______     __    __    
/\__  _\ /\  ___\   /\  == \   /\  == \   /\  __ \   /\  ___\ /\  __ \   /\  == \   /\ "-./  \   
\/_/\ \/ \ \  __\   \ \  __<   \ \  __<   \ \  __ \  \ \  __\ \ \ \/\ \  \ \  __<   \ \ \-./\ \  
   \ \_\  \ \_____\  \ \_\ \_\  \ \_\ \_\  \ \_\ \_\  \ \_\    \ \_____\  \ \_\ \_\  \ \_\ \ \_\ 
    \/_/   \/_____/   \/_/ /_/   \/_/ /_/   \/_/\/_/   \/_/     \/_____/   \/_/ /_/   \/_/  \/_/ 
                                                                                                 

variable my_aws_region {
  default = "<YOUR_AWS_REGION>"
}

variable ec2_image_id {
  default = "<YOUR_UBUNTU_AMI_ID>"
}

variable ec2_key_name {
  default = "<YOUR_SSH_KEY_NAME>"
}

variable ec2_key_filename {
  default = "<YOUR_SSH_FILENAME>"
}

variable "my_ip_addresses" {
  description = "My allowed IP addresses"
  type        = list(string)
  default     = ["<YOUR_IP>/32"]
}

variable "zabbix_access_allowed_ip_addresses" {
  description = "The IP addressess that are allowed to access my Zabbix service interface"
  type        = list(string)
  default     = ["<YOUR_IP>/32"] # example: 0.0.0.0/0
}

variable "zabbix_service_allowed_ip_addresses" {
  description = "The IP addressess that are allowed to send data to my Zabbix service"
  type        = list(string)
  default     = ["<YOUR_IP>/32"] # example: 0.0.0.0/0
}
