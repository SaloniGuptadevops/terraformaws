# Terraform AWS Multi-Environment Infrastructure

A production-grade AWS infrastructure built using reusable Terraform modules with remote state management.

## Architecture

```
terraform-aws-infra/
├── modules/
│   ├── vpc/              # VPC, subnet, IGW, route tables
│   ├── ec2/              # EC2 instance
│   └── security-group/   # Firewall rules
├── environments/
│   ├── dev/              # Development environment
│   └── prod/             # Production environment
└── README.md
```

## What this project creates

| Resource | Dev | Prod |
|---|---|---|
| VPC | 10.0.0.0/16 | 10.1.0.0/16 |
| Public Subnet | 10.0.1.0/24 | 10.1.1.0/24 |
| Internet Gateway | ✅ | ✅ |
| EC2 Instance | t2.micro | t2.micro |
| Security Group | SSH + HTTP | SSH + HTTP |
| Remote State | S3 + DynamoDB | S3 + DynamoDB |

## Key Features

- **Reusable modules** — VPC, EC2, and Security Group modules work across environments
- **Multi-environment** — Dev and prod have isolated state files and separate CIDR ranges
- **Remote state** — State stored in S3 with versioning enabled
- **State locking** — DynamoDB prevents concurrent terraform apply operations
- **Encrypted state** — State file encrypted at rest in S3

## Prerequisites

- Terraform installed
- AWS CLI configured
- AWS Free Tier account
- EC2 Key Pair created in AWS console

## How to run

### Deploy dev environment
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Deploy prod environment
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Destroy when done
```bash
terraform destroy
```

## Remote State Configuration

State is stored in S3 with DynamoDB locking:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

## Modules

### VPC Module
Creates networking infrastructure:
- VPC with DNS support
- Public subnet
- Internet Gateway
- Route table with internet access

### Security Group Module
Creates firewall rules:
- Inbound: SSH (port 22), HTTP (port 80)
- Outbound: All traffic allowed

### EC2 Module
Creates virtual machine:
- Configurable AMI and instance type
- Launched in public subnet
- SSH key pair attached

## Interview Notes

This project demonstrates:
- Terraform module design and reusability
- Multi-environment infrastructure management
- Remote state management with S3 and DynamoDB
- AWS networking — VPC, subnets, IGW, route tables
- Security best practices — least privilege security groups

## Author

Saloni Gupta — DevOps Engineer
