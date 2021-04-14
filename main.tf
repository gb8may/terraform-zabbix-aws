 ______     __     __     ______    
/\  __ \   /\ \  _ \ \   /\  ___\   
\ \  __ \  \ \ \/ ".\ \  \ \___  \  
 \ \_\ \_\  \ \__/".~\_\  \/\_____\ 
  \/_/\/_/   \/_/   \/_/   \/_____/ 


provider "aws" {
  region = var.my_aws_region
  profile = "<YOUR_AWS_PROFILE_NAME>"
  version = "~> 2.7"
}

terraform {
  backend "s3" {
    profile = "<YOUR_AWS_PROFILE_NAME>"
    region  = "<YOUR_AWS_REGION>"
    bucket  = "<YOUR_BUCKET_NAME>"
    key     = "main.tfstate"
  }
}                                                                                                                                                                                        

##########
# SSH KEY
##########

resource "aws_key_pair" "ssh-key" {
  key_name   = var.ec2_key_name
  public_key = file(var.ec2_key_filename)
}

#################
# SECURITY GROUP
################

resource "aws_security_group" "zabbix-server" {
  vpc_id      = aws_vpc.vpc.id
  name        = "Zabbix-Server"
  description = "Security Group for the Zabbix Server."

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.my_ip_addresses
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = var.zabbix_access_allowed_ip_addresses
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.zabbix_access_allowed_ip_addresses
  }
  ingress {
    protocol    = "tcp"
    from_port   = 10050
    to_port     = 10051
    cidr_blocks = var.zabbix_service_allowed_ip_addresses
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"] # service can communitcate out withou restrictions, change it if needed
  }

  tags = {
    Name        = "Zabbix-Server"
    Application = "Zabbix Server"
  } 
}

###############
# EC2 INSTANCE
###############

resource "aws_instance" "instance-zabbix-server" {
  instance_type               = "t3a.small"
  ami                         = var.ec2_image_id
  vpc_security_group_ids      = [aws_security_group.zabbix-server.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  key_name                    = aws_key_pair.ssh-key.key_name
  associate_public_ip_address = true
  user_data                   = file("user-data.sh")

  tags = {
    Name        = "Zabbix-Server"
    Application = "Zabbix Server"
  }
}

resource "aws_eip" "eip-instance-zabbix-server" {
  # count = 1
  instance = aws_instance.instance-zabbix-server.id
  vpc = true
}

output "zabbixserver-eip" {
  value = aws_eip.eip-instance-zabbix-server.public_ip
}

