# Cloud Native DevOps Template

A hands-on portfolio project demonstrating a complete, modern DevOps workflow:
a containerized application, automated CI/CD, and Infrastructure as Code

## Repository Structure

    cloud-native-devops-template/
    ├── .github/workflows/ci.yml   # CI pipeline
    ├── app/
    │   ├── Dockerfile             # nginx image
    │   └── index.html             # web app
    ├── terraform/
    │   ├── main.tf                # provider + S3 bucket
    │   ├── variables.tf           # input parameters
    │   └── outputs.tf             # output values
    ├── docker-compose.yml         # web + localstack
    └── README.md

## How-to-Use

    docker compose up -d          # start app + local AWS
    cd terraform
    terraform init                # load provider
    terraform apply               # create S3 bucket (type: yes)

## CI
On every push to `master`, GitHub Actions:

1. checks out the code
2. builds the Docker image
3. starts the container
4. runs a smoke test with `curl` (with retries)

## Infrastructure as Code (IaC)

Terraform provisions an S3 bucket against **LocalStack**, a local AWS
simulator – no real AWS account or costs required.