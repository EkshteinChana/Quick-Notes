# Quick Notes (Live Demo Available) 
Deployed on GKE | Managed by Terraform | CI/CD via GitHub Actions

## Setup Instructions (For Testing Locally or Deploying from Scratch)
1. Create GCP project 
2. Permissions for Github Actions & Terraform:
    - Create sa for Github actions & Terraform
    - Give it the owner role
    - Create a sa key and save the key in: -  github secrets and name it as GCP_SA_KEY_DEV
                                            - Locally in infra/dev dir
3. In the following files set the project_id var to your project ID:
    - In each workflow in the .github dir.
    - In infra/dev/terraform.tfvars                                              
4. create bucket for the tfstate
5. From the infra/dev path, run:
    ```bash 
        Terraform init
        Terraform apply -auto-approve
    ```
6. Trigger the Docker Build & Push Workflow.

Now the Quick Notes app is running. You only need to vist in the public Endpoint of the quick-notes-frontend service. (You can find it in the gke services)
