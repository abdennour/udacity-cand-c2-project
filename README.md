# Cloud Developer ND Course 2: Design for Performance and Scalability

---

## Prerequisites:

- Docker 18.9 or later
- Docker-compose 1.23 or later

## Getting Started

**Check AWS CLI** `docker-compose run --rm aws --version`
**Check Terraform CLI** `docker-compose run --rm terraform version`
**Configure AWS_CLI with credentials**
- Create AWS IAM user with programatic access and with privileges to access EC2, IAM and Lambda.
- Configure the user keys with the local environment:
`docker-compose run --rm aws-configure`

## Deploy Exercise 1

**Terraform init - install dependencies**
```sh
docker-compose -f docker-compose.yaml -f docker-compose.exercise1.yaml run --rm terraform init
```

**Terraform Deploy**

```sh
docker-compose -f docker-compose.yaml -f docker-compose.exercise1.yaml run --rm terraform apply -auto-approve
```

## Deploy Exercise 2

**Terraform init - install dependencies**
```sh
docker-compose -f docker-compose.yaml -f docker-compose.exercise2.yaml run --rm terraform init
```

**Terraform Deploy**

```sh
docker-compose -f docker-compose.yaml -f docker-compose.exercise2.yaml run --rm terraform apply -auto-approve
```


## Project  Instructions

### Exercise 1

1. Download the [starter code](https://github.com/udacity/cand-c2-project).
2. In the main.tf file write the code to provision
   * AWS as the cloud provider
   * Use an existing VPC ID
   * Use an existing public subnet
   * 4 AWS t2.micro EC2 instances named Udacity T2
   * 2 m4.large EC2 instances named Udacity M4
3. Run Terraform.
4. Take a screenshot of the 6 EC2 instances in the AWS console and save it as `Terraform_1_1`.
5. Use Terraform to  delete the 2 m4.large instances
6. Take an updated screenshot of the AWS console showing only the 4 t2.micro instances and save it as `Terraform_1_2`

### Exercise 2

1. In the  Exercise_2 folder, write the code to deploy an AWS Lambda Function using Terraform. Your code should include:

   * A lambda.py file
   * A main.tf file with AWS as the provider, and IAM role for Lambda, a VPC, and a public subnet
   * An outputs.tf file
   * A variables.tf file with an AWS region

2. Take a screenshot of the EC2 instances page
3. Take a screenshot of the VPC page
