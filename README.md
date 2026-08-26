# Cloud Native DevOps Template

A hands-on portfolio project demonstrating a complete, modern DevOps workflow:
a containerized application, automated CI/CD, and Infrastructure as Code

## Architecture Diagram
```text
Internet ───┐
            │
            ▼
┌───────────────────────────────────────┐
│                                       │
│       Application Load Balancer       │
│         (Public Subnet A + B)         │
│                                       │
└───────────────────┬───────────────────┘
                    │
      ┌─────────────┼─────────────┐
      ▼             ▼             ▼
┌───────────┐ ┌───────────┐ ───────────┐
│ ASG EC2-1 │ │ ASG EC2-2 │ │ DynamoDB  │
│ (Subnet A)│ │ (Subnet B)│ │ (Private) │
└───────────┘ └───────────┘ └───────────┘
```
## Repository Structure

    cloud-native-devops-template/
    ├── .github/workflows/ci.yml   # CI pipeline
    ├── app/
    │   ├── Dockerfile             # nginx image
    │   └── index.html             # web app
    ├── terraform/
    │   ├── main.tf                # provider + S3 bucket
    │   ├── variables.tf           # input parameters
    │   ├── outputs.tf             # output values
    |   ├── vpc.tf                 # virtual private cloud + 3 subnets
    |   ├── sg.tf                  # security groups
    |   ├── rds.tf                 # relational databank
    |   ├── iam.tf                 # identity access manager
    |   ├── ebs.tf                 # elastic block store
    |   ├── dynamodb.tf            
    |   ├── asg.tf                 # auto scaling groups
    |   └── alb.tf                 # application load balancer
    ├── docker-compose.yml         # web + localstack
    └── README.md

## Prerequisites
- Docker & Docker Compose
- Terraform (>= 1.0)
- LocalStack (via Docker Compose included)

## How-to-Use

    docker compose up -d          # start app + local AWS
    cd terraform
    terraform init                # load provider
    terraform apply               # create aws Infrastructure (type yes to confirm)

## CI/CD Pipeline

On every **push to `master`** and every **pull request**, GitHub Actions:

1. Checks out the code
2. Builds the Docker image
3. Starts the container
4. Runs a smoke test with `curl` (5 retries, connection-refused handling)
5. Displays container logs on failure

## Infrastructure as Code (IaC)

Terraform creates a virtual private cloud, within that VPC there are three subnets - of which two are public and one is private. The ASG and ALB span across the two subnets in different availability zones in order to simulate high availability. The EC2-instances which are created through the ASG using the launch template drop every type of traffic not being forwarded from the ALB with the help of pre defined security groups. Additionally, the Auto Scaling Group automatically registers newly launched EC2 instances with the ALB Target Group and deregisters them upon termination. The ALB then actively performs health checks with an interval of 30 seconds. 


## LocalStack Limitations & Production Readiness
This repository uses LocalStack for local AWS emulation. Please note:
RDS/Databases: LocalStack's RDS emulation is limited. Therefore, database resources are omitted from this local setup to keep the CI pipeline fast and stable. However, the VPC and Subnet architecture is designed to easily accommodate a private RDS instance in a real AWS environment.
ASG Health Checks: LocalStack does not emulate real EC2 instances, so ASG auto-healing based on ALB health checks cannot be fully tested locally. The Terraform code, however, is 1:1 production-ready for real AWS.
