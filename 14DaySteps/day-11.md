# Day 11 -Create a CI/CD pipeline
- Push code to GitHub
- GitHub builds Docker image
- Image is pushed to ECR
- EC2 automatically runs the latest container
- 
We will use:
- GitHub
- GitHub Actions
- Docker
- Amazon Elastic Container Registry
- Amazon EC2

- Step 1 — Create GitHub Secrets and navigate to 'Settings → Secrets → Actions'
  - Add these secrets.
  - AWS_ACCESS_KEY_ID: Your AWS access key.
  - AWS_SECRET_ACCESS_KEY: Your AWS secret key.
  - AWS_REGION: us-east-1
  - ECR_REPOSITORY: flask-devops-app
  - ECR_REGISTRY: 859525218899.dkr.ecr.us-east-1.amazonaws.com

- Step 2 — Create GitHub Actions Folder
```
mkdir -p .github/workflows
```
Create the workflow file:
```
nano .github/workflows/deploy.yml
```
- Step 3 — Add CI/CD Pipeline
```
name: Build and Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ${{ secrets.AWS_REGION }}

    - name: Login to ECR
      run: |
        aws ecr get-login-password --region $AWS_REGION \
        | docker login --username AWS --password-stdin ${{ secrets.ECR_REGISTRY }}

    - name: Build Docker image
      run: |
        docker build -t flask-devops-app .

    - name: Tag image
      run: |
        docker tag flask-devops-app:latest ${{ secrets.ECR_REGISTRY }}/flask-devops-app:latest

    - name: Push to ECR
      run: |
        docker push ${{ secrets.ECR_REGISTRY }}/flask-devops-app:latest
```
- Step 4 — Commit the Pipeline
- Go to: GitHub → Actions tab You should see the workflow running.
  - GitHub will:
  - Pull your code
  - Build Docker image
  - Push to ECR
 
- Step 6 — Verify Image in AWS (Open the image to see most updated image)
  - Amazon Elastic Container Registry-Repositories → flask-devops-app
