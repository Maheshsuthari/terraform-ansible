# terraform-ansible
#automate configuration managment with terraform, while launching vms you will be allow ansible to make application changes
#Steps
git clone https://github.com/Maheshsuthari/terraform-ansible
cd terraform-ansible
cd dev
terraform init
#This code will create a different OS based on variable which you are passing while terraform apply
#You can pre-validate by running terraform plan -var os_ami="windows/linux", by default linux settled
#for windows vm 
terraform apply --auto-approve -var os_ami="windows"
but anisble will throw error we are still working on to exclude ansible on windows os

Now will go with default linux os

terraform apply --auto-approve 

you will get public ip 

terraform output webserver.public_ip

#open chrome and enter the public-ip

