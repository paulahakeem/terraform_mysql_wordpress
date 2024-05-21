# Terraform Infrastructure Deployment

## Overview
This Terraform code automates the deployment of a basic AWS infrastructure including a Virtual Private Cloud (VPC), subnets, route tables, internet gateway, NAT gateway, security groups, EC2 instances, and an RDS instance.

## Resources Created

### VPC
- Creates a VPC with specified CIDR block, DNS support, and DNS hostnames.

### Subnets
- Creates subnets within the VPC across specified availability zones.

### Route Tables
- Defines route tables for both public and private subnets.
- Associates the public subnet with an internet gateway for public internet access.
- Associates the private subnet with a NAT gateway for outbound internet access.

### Internet Gateway & NAT Gateway
- Creates an internet gateway for the VPC.
- Associates the internet gateway with the VPC.
- Allocates an Elastic IP address for the NAT gateway.
- Creates a NAT gateway within the public subnet.

### Security Groups
- Defines a security group allowing specified inbound traffic.
- Allows inbound traffic on ports 80, 22, and 443.
- Allows all outbound traffic.

### EC2 Instances
- Deploys EC2 instances with specified configurations (AMI, instance type, subnet, security group, etc.).
- Configures public IP address association for instances.
- Assigns key pair for SSH access.

### RDS Instance
- Creates an RDS instance with specified configurations (engine, storage, username, password, etc.).
- Configures the instance to be not publicly accessible.

## Modules

### Network
- Manages VPC, subnets, route tables, internet gateway, NAT gateway, and security groups.

### Virtual Machines (VMs)
- Deploys EC2 instances for backend and frontend services.

### Database
- Creates an RDS instance for database management.

## Configuration
- Parameters such as VPC CIDR block, subnet details, security group settings, EC2 configurations, and RDS settings are provided as variables to customize the deployment.

## Usage
1. Ensure Terraform is installed.
2. Update the variables in `variables.tf` to match your requirements.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform apply` to apply the Terraform configuration and create the infrastructure.
5. After deployment, the public IP addresses of EC2 instances are stored in `instance_ip.txt` for reference.

## Note
- Ensure appropriate AWS credentials are configured for Terraform to manage the infrastructure.
- Review the security settings and adjust them according to your specific requirements and best practices.
- This README provides a high-level overview; for detailed understanding, refer to individual Terraform configuration files.
