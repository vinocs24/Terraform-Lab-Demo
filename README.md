# Terraform-Lab-Demo
Terraform Lab: Setting up wordpress application in EC2 with ELB attached and creating RDS Mysql DB using Modules
Setting up wordpress application on apache web server. 
Setting up wordpress application on apache web-server installed in EC2 machine via user_data template. Create and attach ELB to the EC2 instance for traffic routing and similarly create RDS Mysql database with user credentials to configure wordpress application.
Use Modules in terraform to build the above environment.
Store terraform state file to S3 using terraform backend.
AWS Resources:
●	EC2 with user_data template
●	Elastic Load Balancer
●	RDS

Use existing VPC, Subnets, Security groups to configure the above setup to launch the environment. Use Modules in terraform to build the infrastructure.
Configuration
https://www.terraform.io/docs/providers/aws/r/vpc.html
https://www.terraform.io/docs/providers/aws/r/lb.html
●	Use existing vpc and subnets.
●	Use existing security groups for EC2 instance and ELB

Resource Dependencies

	https://www.terraform.io/docs/providers/aws/r/lb.html
●	Create ALB for distributing application traffic across multiple targets.
	https://www.terraform.io/docs/providers/aws/d/elb.html
●	Create EC2 instance and install the prerequisites using user_data templates. 
https://www.terraform.io/docs/providers/template/d/file.html
●	Create RDS instance with DB and user credentials.
	https://www.terraform.io/docs/providers/aws/r/db_instance.html
●	Use DB subnet group to launch RDS instance
	https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html
●	Use modules in terraform to build the environment
	https://www.terraform.io/docs/modules/index.html
	https://www.terraform.io/docs/modules/usage.html
	
Input Variables
https://www.terraform.io/intro/getting-started/variables.html
●	Create a variable.tf file within your Terraform working directory and call them within the Main Terraform file.
●	Use the following resources from variable file.
o	1.Instance security group 
o	2.ELB security group
o	3.Subnets for ELB and EC2
o	4.Instance - keyname

Output Variables
https://www.terraform.io/intro/getting-started/outputs.html
▪	Display the following output variables.
1.	EC2 instance ID
2.	ELB-Hostname
3.	RDS Endpoint
Expected terraform files for this build is listed below
●	README.md 
●	Main.tf
●	Modules
	1.EC2
	2.ELB
	3.RDS
●	Every module should have,
	1.Main.tf
	2.Vars.tf
	3.Outputs.tf
●	In addition EC2 module will have a shell script file as user_data to install the components. (installing-components.sh)

Terraform Apply
Run terraform apply to execute.
https://www.terraform.io/intro/getting-started/build.html

