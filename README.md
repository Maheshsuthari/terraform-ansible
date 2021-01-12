# terraform-ansible


#Automate configuration managment(Ansible) with terraform.
Develop a terraform script to invoke the created module to create a VM. Also use appropriate resource to invoke ansible playbook at the end of VM creation. Ansible playbook should install a nginx web server

#Pre-requisites

terraform 

ansible

aws_cli

azure_cli


#Steps

git clone https://github.com/Maheshsuthari/terraform-ansible

cd terraform-ansible

cd dev

#Before you initialize terraform you need to configure aws/azure in your host then proceed as mention below

terraform init

#Once Terraform state file created you can verify which resources will be created for eg:

#You can pre-validate by running terraform plan -var os_ami="windows/linux", default os is linux ubuntu.
 
#for windows vm you can run below command or else default will be linux(ubuntu):

terraform apply --auto-approve -var os_ami="windows"

#if you want go with default Operating system please run as below

terraform apply --auto-approve 

#using terraform remote-exec we will install ansible in created vm using provisioner, once installed, you can add local-exec and run ansible-playbook from your local machine. It is not required 
 Remote-exec will help you assure VM is up and running and anisible will install 
 Install miginx from your local machine. 

#Nginx play book nginx. Yaml have defined nginx roles, this roles have tasks, etc
   Tree:
    nginx.yaml
    roles

      tasks
      
      Handlers
 
      defaults

       Vars
       
       templates



#you will get public ip by running terraform output,

terraform output webserver.public_ip

#open chrome and enter the public-ip

