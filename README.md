Overview:

This README provides instructions for setting up and executing a Terraform pipeline to provision AWS infrastructure. The setup includes creating an Amazon EKS cluster, VPC, and other necessary resources.

Prerequisites:

AWS Account: Ensure you have an AWS account with appropriate permissions to create resources such as VPCs, EKS clusters, and IAM roles.
Terraform: Install Terraform on your local machine. You can download it from Terraform's official website.
GitHub Account: If using GitHub Actions for CI/CD, ensure you have a GitHub account and repository.

1. Set Up AWS Credentials:
   
  - Created the user - github-actions with the following permissions - S3FullAccess,DynamoDBFullaccess,EKSClusterPolicy and EKSWorkerNodePolicy.
  - Use the access and secretkey of the github-action user and integrate it with github.

2. Terraform Configuration Files:

   ![image](https://github.com/user-attachments/assets/7eb09d03-a2bf-42cf-94fe-0fbb1551e08e)

3. Running Terraform Commands:
   
   terraform init
   terraform plan
   terraform apply

   Additionaly you can add validate to validate the syntax of HCL.

3. GitHub Actions CI/CD Pipeline
   Path - .github/workflows/deploy.yml
   
