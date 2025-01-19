# **AWS Infrastructure Setup using Terraform**

## **Overview**

This repository provides a Terraform-based configuration for deploying a scalable infrastructure on AWS. The architecture includes a Virtual Private Cloud (VPC), subnets (both public and private), Application Load Balancers (ALBs), Auto Scaling Groups (ASGs), Launch Templates, and IAM roles. This setup is designed to ensure high availability, security, and scalability for your applications.

## **Modules**

The infrastructure is divided into multiple Terraform modules, each responsible for a specific aspect of the infrastructure:

- **networking**: VPC, subnets, and security groups
- **compute**: EC2 instances, auto scaling groups, load balancers
- **rds**: RDS database setup
- **iam_roles**: IAM roles and instance profiles

## **Prerequisites**

Before starting, ensure that the following tools are installed:

- **Terraform** (>= 1.0)
- **AWS CLI**
- **AWS Account** with proper IAM permissions

## **Setup**

### **1. Clone the Repository**

Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/aws-infrastructure-terraform.git
cd aws-infrastructure-terraform
```
### **2. Configure AWS CLI**
Make sure your AWS CLI is configured with the correct credentials and region:

```bash
aws configure
```
### **3. Initialize Terraform**
Initialize the Terraform configuration:

```bash
terraform init
```
### **4. Set Variables**
You need to provide values for variables used in the configuration. Create a terraform.tfvars file or pass them directly in the command line.

```terraform
variables.tf

variable "project" {
  description = "Project name for resource naming"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  default     = "Hassan"
}

variable "db_password" {
  description = "Database master password"
  default     = "cloud#1234"
}
```
### **5. Plan the Infrastructure**
Run the following command to preview the infrastructure changes Terraform will make:

```bash
terraform plan
```

