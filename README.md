# Laravel + Nginx + EKS Deployment Pipeline


## Repository Structure

```plaintext
mnkre-laravel-pipeline/
├── Dockerfile                # Defines the Docker image for Laravel + Nginx
├── nginx.conf                # Nginx configuration for serving the Laravel application
├── Jenkinsfile               # CI/CD pipeline configuration for Jenkins
├── terraform/                # Terraform scripts for infrastructure provisioning
│   ├── main.tf
├── kubernetes/               # Kubernetes manifests for deploying the app
│   ├── deployment.yaml
├── ansible/                  # Ansible playbook for post-provisioning tasks
│   └── playbook.yml
├── src/                      # Enhance Laravel application source code
|--- routes/web.php
├── README.md                 # Project documentation
```

---

## Prerequisites

1. **Tools Installed**:
   - Docker
   - Terraform
   - kubectl
   - AWS CLI
   - Ansible
   - Jenkins or GitLab CI/CD configured
2. **AWS Free Tier Account** with permissions to create EKS clusters and related resources.

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/mnkre/london-laravel-app.git
cd mnkre-laravel-pipeline
```

### 2. Build the Laravel Application Locally
```bash
composer install
npm install && npm run production
php artisan test
```

### 3. Build and Test the Docker Image Locally
```bash
docker build -t mnkre-laravel-app:latest .
docker run -p 8080:80 mnkre-laravel-app:latest
```
Visit `http://localhost:8080` to verify the application is running.

### 4. Provision AWS Infrastructure
Navigate to the `terraform/` directory and execute:
```bash
terraform init
terraform plan
terraform apply
```
This will provision the VPC, EKS cluster, and associated resources.

### 5. Deploy the Application to EKS
```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```
Once deployed, the application will be accessible via the LoadBalancer endpoint created by the service.

### 6. Configure Jenkins Pipeline
1. Add a new pipeline in Jenkins and point it to this repository.
2. Use the `Jenkinsfile` provided in the repository.
3. Trigger the pipeline manually or set it up for automatic triggers.

---

## Pipeline Workflow

1. **Clone Repository**: Fetches the latest code.
2. **Build Laravel Application**: Installs PHP and JavaScript dependencies.
3. **Run Unit Tests**: Executes tests to validate the application.
4. **Build Docker Image**: Creates a Docker image with Laravel and Nginx.
5. **Push Docker Image**: Pushes the Docker image to the container registry.
6. **Deploy to EKS**: Deploys the application to the Amazon EKS cluster.

---

## Enhancements

1. **Monitoring**: Integrate Prometheus and Grafana for real-time monitoring.
2. **Helm**: Package the application using Helm for better manageability.
3. **Secrets Management**: Use AWS Secrets Manager for Laravel's `.env` file.




