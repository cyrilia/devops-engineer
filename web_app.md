# CAPSTONE PROJECT:

## Project Overview:
Build a stateless web application on AWS with high resilience, security, and fault tolerance using container orchestration (ECS/EKS), Terraform, Docker, and GitHub.

_I will be creating a simple static web application with two pages. The content of these pages will be quite straightforward, such as one landing page (/) and a secondary page (/about). The content will be kept minimal, focusing on the functionality and deployment aspects rather than intricate application logic. As a junior devOps engineer, this allows me to concentrate on implementing the infrastructure components using AWS services, Terraform, and Docker without getting bogged down in complex application development._

## Deliverables:

1. ### Design
Sketch the architecture of the web application.
Identify AWS services needed for resilience, security, and fault tolerance.
Document high-level design decisions.

2. ### Infrastructure Coding
1. Docker Image
Create a Dockerfile for the web application with 2 static pages.
Test locally to ensure the container runs as expected.

2. ECR
Push the Docker image to Amazon ECR.

3. Container Orchestration
Set up EKS to host the container.
Consider utilizing Fargate for additional benefits.

4. Load Balancer
Configure a public load balancer to resolve /page1 and /page2.

5. Terraform Code
Write Terraform code for all resources (excluding Docker build and push to ECR).
Utilize only raw Terraform resources without external modules.

6. Testing and Validation
Test the infrastructure in your personal AWS account.
Capture and share screenshots of the deployed application.
Ensure Terraform code can be executed locally and produces expected output.

3. ### GitHub Repository (Used throughout the Project)
Create a public GitHub repository.
Upload design documents and code regularly.
Clearly mention instructions and requirements in the repository.

## Sketch of the web application architecture:
'''scss
User ────> Public Load Balancer ───> Container Orchestration (EKS) ───> Docker Container
                                   │
                                   ├──> ECR (Elastic Container Registry)
                                   │
                                   ├──> Other AWS Services (e.g., VPC, Security Groups)
                                   │
                                   └──> Terraform (Infrastructure as Code or CloudFormation)
'''

*** This is a high level overview. My goal is to create a basic yet resilient architecture for my web application on AWS.

**Details**
User: This represents the end-users accessing my web application.

Public Load Balancer: Handles incoming traffic and distributes it to the container instances within the container orchestration platform.

Container Orchestration (EKS): Manages the deployment, scaling, and orchestration of Docker containers. This layer ensures high availability and fault tolerance.

Docker Container: Contains the simple web application with two static pages.

ECR (Elastic Container Registry): Stores my Docker image, allowing me to manage and deploy container images.

Other AWS Services: Includes VPC (Virtual Private Cloud), Security Groups, and other necessary AWS components to enhance security and network configuration.

Terraform (Infrastructure as Code): Defines and deploys the entire infrastructure on AWS, excluding the Docker build and push to ECR. Utilizes raw Terraform resources for simplicity.


```txt
    +-------------------+     +-------------------------+     +------------------------+
    |                   |     |                         |     |                        |
    |  Client Browser   |     |   AWS Elastic Load      |     |   Amazon Elastic       |
    |                   |     |   Balancer (Public)     |     |   Kubernetes Service  |
    +---------+---------+     |                         |     |                        |
              |               +-------------+-----------+     |                        |
              v                             |                 |                        |
    +-------------------+                    |                 |                        |
    |                   |                    |                 |                        |
    |   Amazon Route    |                    |                 |                        |
    |   53 (DNS)         +--------------------+                 |                        |
    |                   |                      \                |                        |
    +---------+---------+                       \               |                        |
              |                                 \              |                        |
              v                                  \             |                        |
    +-------------------+                        \            |                        |
    |                   |                          \           |                        |
    |   AWS Certificate |                           \          |                        |
    |   Manager         |                            \         |                        |
    |                   |                             \        |                        |
    +---------+---------+                              \       |                        |
              |                                        \      |                        |
              v                                         \     |                        |
    +-------------------+                               \    |                        |
    |                   |                                \   |                        |
    |   AWS Global      |                                 \  |                        |
    |   Accelerator     |                                  \ |                        |
    |                   |                                   \|                        |
    +---------+---------+                                    +------------------------+
              |                                     
              v                                   
    +-------------------+                             
    |                   |                             
    |   Amazon ECR      |                             
    |   (Docker Images) |                             
    |                   |                             
    +---------+---------+                             
              |                                       
              v                                       
    +-------------------+                             
    |                   |                             
    |   Amazon EKS      |                             
    |   (Kubernetes)    |                             
    |                   |                             
    +-------------------+                             
              |                                       
              v                                       
    +-------------------+                             
    |                   |                             
    |   Application     |                             
    |   Containers      |                             
    |                   |                             
    +-------------------+                             
```

### Explanation: (potential adjustments)

Client Browser: Represents external users accessing the web application.

Amazon Route 53 (DNS): Manages domain name resolution for the application.

AWS Elastic Load Balancer (Public ALB): Serves as the entry point for incoming traffic, distributing it across the available instances.

AWS Certificate Manager: Manages SSL/TLS certificates for secure communication.

AWS Global Accelerator: Improves the availability and fault tolerance of applications by using static IP addresses.

Amazon ECR (Elastic Container Registry): Stores Docker images, allowing EKS to pull the required images for deployment.

Amazon EKS (Elastic Kubernetes Service): Manages the containerized application using Kubernetes. Orchestrates the deployment and scaling of Docker containers.

Application Containers: Stateless web application running inside Docker containers, deployed and managed by EKS.

The diagram demonstrates a comprehensive architecture that utilizes various AWS services to achieve the desired goals of resilience, security, and fault tolerance. It also reflects the use of containerization, orchestration, and automation through Terraform and GitHub Actions, aligning with the project requirements.


## Infrastructure Coding

### Docker Image
1. Creating a Dockerfile for the web application
```Dockerfile
# Use a lightweight web server as a base image
FROM nginx:alpine

# Copy your static HTML pages into the default web server directory
COPY index.html /usr/share/nginx/html/
COPY about.html /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80
```

2.  Creating 2 static HTML pages (landing page and about page)
Sample `index.html` file
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Web App - Home</title>
</head>
<body>
    <h1>Welcome to My Web App!</h1>
    <p>This is the home page.</p>
</body>
</html>
```

Sample `about.html` file
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Web App - About</title>
</head>
<body>
    <h1>About Us</h1>
    <p>This is the about page.</p>
</body>
</html>
```

3. Build and run the Docker Image
```bash
#building the docker image
docker build -t my-web-app .

#running the docker image
docker run -p 8080:80 my-web-app
```

4. Access the web application
Open a web browser and navigate to `http://localhost:8080` to see the web application.

**Explanation:**
* This Dockerfile uses the official Nginx web server image, which is lightweight and commonly used for serving static content.
* It copies your index.html and about.html files into the default directory for Nginx to serve static content (/usr/share/nginx/html/).
* The EXPOSE 80 line indicates that the web server inside the container will listen on port 80.