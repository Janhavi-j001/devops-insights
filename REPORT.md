# DevOps Node.js CI/CD Project

## 🔧 Architecture Diagram
(Include your draw.io or Lucidchart image here)

## 🧠 Git Branching Strategy
- `main`: Production-ready code
- `develop`: Active development
- Feature branches merged into develop
- Pull requests required for merging into `main`

## 🏗 Terraform Resource Summary
- VPC, Subnet, EC2, Security Group, Elastic IP

## 🔄 Pipeline Execution
- Git push to `develop` triggers Jenkins pipeline
- Jenkins builds Docker image & pushes to DockerHub
- Terraform provisions AWS EC2
- Ansible deploys app container
