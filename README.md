# DevOps Assignment

This project is a full-stack web application with a Next.js frontend and a FastAPI backend. The infrastructure is provisioned on AWS using Terraform, and the servers are configured using Ansible. The entire deployment process is automated with a GitLab CI/CD pipeline.

## Architecture

The application is deployed on AWS with the following architecture:

```
                               +-----------------+                +-------------------------------+
                               |   GitLab CI/CD  |<-------------- |  Push Code to Gitlab Project  |
                               +-----------------+                +-------------------------------+
                                       |
                                       v
+---------------------------------------------------------------------------+
|                                  AWS Cloud                                |
|                                                                           |
|  +-------------------------------------------------------------------+    |
|  |                            VPC                                    |    |
|  |                                                                   |    |
|  |  +-----------------------+      +------------------------+        |    |
|  |  |    Public Subnet      |      |    Private Subnet      |        |    |
|  |  |                       |      |                        |        |    |
|  |  |  +-----------------+  |      |  +------------------+  |        |    |
|  |  |  | Frontend Server |<--------|  | Backend Server   |  |        |    |
|  |  |  |  (Next.js)      |  |      |  |  (FastAPI)       |  |        |    |
|  |  |  +-----------------+  |      |  +------------------+  |        |    |
|  |  |        ^              |      |         ^              |        |    |
|  |  |        |              |      |         |              |        |    |
|  |  |  +-----------------+  |      |         |              |        |    |
|  |  |  |  Bastion Host   |-------------------+              |        |    |
|  |  |  +-----------------+  |      |                        |        |    |
|  |  +-----------------------+      +------------------------+        |    |
|  +-------------------------------------------------------------------+    |
+---------------------------------------------------------------------------+
       ^
       |
+------+------+
|  Terraform  |
+-------------+
```

## Technologies Used

*   **Frontend:** [Next.js](https://nextjs.org/), [React](https://reactjs.org/)
*   **Backend:** [FastAPI](https://fastapi.tiangolo.com/), [Python](https://www.python.org/)
*   **Infrastructure as Code:** [Terraform](https://www.terraform.io/)
*   **Configuration Management:** [Ansible](https://www.ansible.com/)
*   **CI/CD:** [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
*   **Containerization:** [Docker](https://www.docker.com/)
*   **Cloud Provider:** [Amazon Web Services (AWS)](https://aws.amazon.com/)

## Project Structure

```
.
├── ansible_playbooks/      # Ansible playbooks for server configuration
│   ├── backend_pb.yaml
│   ├── bastion_pb.yaml
│   ├── frontend_pb.yaml
│   ├── inventory.yaml
│   └── test_pb.yaml
├── backend/                # FastAPI backend application
│   ├── app/
│   │   └── main.py
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/               # Next.js frontend application
│   ├── pages/
│   │   └── index.js
│   ├── Dockerfile
│   ├── next.config.js
│   ├── nginx.conf
│   └── package.json
├── terraform/              # Terraform files for infrastructure provisioning
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── .gitlab-ci.yml          # GitLab CI/CD pipeline configuration
```

## Prerequisites

*   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
*   [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
*   [Docker](https://docs.docker.com/get-docker/)
*   [GitLab Account](https://gitlab.com/users/sign_up)
*   [AWS Account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
*   [Docker Hub Account](https://hub.docker.com/signup)

## Setup and Deployment

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Configure AWS Credentials:**
    Ensure your AWS credentials are configured correctly for Terraform to access your AWS account.

3.  **Configure GitLab CI/CD Variables:**
    Set the following variables in your GitLab project's CI/CD settings:
    *   `DOCKERHUB_USER`: Your Docker Hub username.
    *   `DOCKERHUB_PASS`: Your Docker Hub password or access token.
    *   `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
    *   `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.

4.  **Run the CI/CD Pipeline:**
    Push a commit to the `main` branch to trigger the CI/CD pipeline. The pipeline will automatically build, test, and deploy the application.

## CI/CD Pipeline

The CI/CD pipeline is defined in the `.gitlab-ci.yml` file and consists of the following stages:

*   **`build`:** Builds the Docker images for the frontend and backend.
*   **`test`:** Runs unit tests on the backend using `pytest`.
*   **`push`:** Pushes the Docker images to Docker Hub.
*   **`deploy`:** Deploys the application to the AWS servers.
*   **`cleanup`:** Removes dangling Docker images from the servers and the GitLab runner.

## API Endpoints

The backend exposes the following API endpoints:

*   `GET /api/health`: Returns the health status of the backend.
*   `GET /api/message`: Returns a success message from the backend.

## Future Improvements

*   Implement more comprehensive tests for the frontend and backend.
*   Use a more robust solution for managing secrets, such as HashiCorp Vault or AWS Secrets Manager.
*   Add HTTPS support with SSL/TLS certificates.
*   Implement a database to store and retrieve data.
*   Improve the UI/UX of the frontend.
