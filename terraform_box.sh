#!/bin/bash

#████████╗███████╗██████╗ ██████╗  █████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗    ██████╗  ██████╗ ██╗  ██╗
#╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║    ██╔══██╗██╔═══██╗╚██╗██╔╝
#   ██║   █████╗  ██████╔╝██████╔╝███████║█████╗  ██║   ██║██████╔╝██╔████╔██║    ██████╔╝██║   ██║ ╚███╔╝ 
#   ██║   ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║    ██╔══██╗██║   ██║ ██╔██╗ 
#   ██║   ███████╗██║  ██║██║  ██║██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║    ██████╔╝╚██████╔╝██╔╝ ██╗
#   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

# Author: Mayara Gouveia

dialog                                    \
   --title 'Terraform BOX'                \
   --infobox '\nLoading. Please wait...'  \
   0 0

if ! dialog -v &> /dev/null
then
	sudo apt update && sudo apt install dialog -y
fi

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - &> /dev/null
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &> /dev/null

dialog                                              \
   --title 'Terraform BOX'                          \
   --yesno '\nWould you like to install Terraform?' \
   0 0

if [ $? = "0" ]
then
	dialog                                    \
   	--title 'Terraform BOX'                \
   	--infobox '\nInstalling. Please wait...'  \
   	0 0
	sudo apt-get update &> /dev/null && sudo apt-get install terraform -y &> /dev/null
fi

s3_aws_region=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter your S3 bucket region:' 0 0 )
bucket_name=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter your S3 bucket name:' 0 0 )
aws_region=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter the AWS region:' 0 0 )
ec2_type=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter the EC2 instance type:' 0 0 )
ami_id=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter the AMI ID:' 0 0 )
ssh_key=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter your SSH public key:' 0 0 )
pem_file=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter your PEM file name:' 0 0 )
ip_addr=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter your IP address:' 0 0 )
zbx_usr=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter the Zabbix username:' 0 0 )
zbx_pwd=$( dialog --stdout --title 'Terraform BOX' --inputbox 'Enter the Zabbix password:' 0 0 )

cat template_files/main.tmp | sed "s/{{S3_AWS_REGION}}/${s3_aws_region}/g" | sed "s/{{BUCKET_NAME}}/${bucket_name}/g" | sed "s/{{EC2_TYPE}}/${ec2_type}/g" > main.tf
cat template_files/user-data.tmp | sed "s/{{zbx_usr}}/${zbx_usr}/g" | sed "s/{{zbx_pwd}}/${zbx_pwd}/g" > user-data.sh
cat template_files/variables.tmp | sed "s/{{AWS_REGION}}/${aws_region}/g" | sed "s/{{AMI_ID}}/${ami_id}/g" | sed "s/{{SSH_KEY}}/${ssh_key}/g" | sed "s/{{PEM_FILE}}/${pem_file}/g" | sed "s/{{IP_ADDR}}/${ip_addr}/g" > variables.tf

while true; do

action=$( dialog --stdout --title 'Terraform BOX' \
	--menu 'Choose one option:' 0 0 0 \
	      1 'Terraform Init' \
              2 'Terraform Plan' \
              3 'Terraform Apply' \
              4 'Terraform Destroy' \
      	      5 'Exit' )

case $action in
	1) clear && terraform init && sleep 10s ;;
	2) clear && terraform plan && sleep 10s ;;
	3) clear && terraform apply -auto-approve && sleep 10s ;;
	4) clear && terraform destroy -auto-approve && sleep 10s ;;
	5) clear && exit 1 ;;
esac

done
