# AWS DevOps End-to-End Project

This project demonstrates a complete DevOps workflow on AWS Free Tier.

## Tech Stack
- Application: Python (Flask)
- Containerization: Docker
- Infrastructure as Code: Terraform
- CI/CD: GitHub Actions
- Cloud Provider: AWS
- Monitoring: CloudWatch

## Goal
- To build, deploy, and automate a containerized application on AWS using modern DevOps practices.
- To build, deploy, and automate a containerized application on K8s locally with Minikube.
- All files deployed with deply.yml on git actions

```
your-project/
├── app.py
├── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
└── .github/
    └── workflows/
        └── deploy.yml
```
