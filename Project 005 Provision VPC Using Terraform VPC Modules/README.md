# Steps to Provision VPC Using Terraform VPC Modules
# Working Folder
terraform-manifests/v1-vpc-module


# Terraform Initialize
terraform init
Observation:
1. Verify if modules got downloaded to .terraform folder


# Terraform Validate
terraform validate


# Terraform plan
terraform plan


# Terraform Apply
terraform apply -auto-approve
Observation:
1) Verify VPC
2) Verify Subnets
3) Verify IGW
4) Verify Public Route for Public Subnets
5) Verify no public route for private subnets
6) Verify NAT Gateway and Elastic IP for NAT Gateway
7) Verify NAT Gateway route for Private Subnets
8) Verify no public route or no NAT Gateway route to Database Subnets
9) Verify Tags


# Terraform Destroy
terraform destroy -auto-approve


# Delete Files
rm -rf .terraform*
rm -rf terraform.tfstate*


# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html


# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html

# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy


# Clean-Up Files
rm -rf .terraform*
