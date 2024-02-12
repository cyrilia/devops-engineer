# Deploying to AWS with Terraform and Ansible

## Setting Up the Environment
**Terraform Installation**
>sudo wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
>sudo yum -y install unzip
>unzip terraform_0.12.29_linux_amd64.zip
>sudo mv terraform /usr/local/bin

**AWS CLI and Ansible Installation**
>sudo yum -y install python3-pip
>pip3 install awscli --user
>sudo pip3 install --upgrade pip
>pip3 install ansible --user
>wget https://raw.githubusercontent.com/linuxacademy/content-deploying-to-aws-ansible-terraform/master/aws_la_cloudplayground_version/ansible.cfg

## Terraform Infrastructure as Code (IaC)

### Understanding Popular Commands
1. **Terraform Init:**
* Initializes working directory.
* Downloads and includes modules and providers (Except third party) in tf file.
* Needs to be run before deploying infrastructures.

2. **Terraform Fmt:**
* Formats templates for readability.
* Ensures consistent code style.
* Safe to run at any time.

3. **Terraform Validate:**
* Validates config files.
* Safe to run at any time.

4. **Terraform Plan**
* Creates an execution plan.
* Fail-safe before actual deployment.
* Execution plan can be saved using the -out flag.

5. **Terraform Apply:**
* Deploys the execution plan.
* Prompts before deploying.
* Displays the execution plan again.


### Persisting Terraform State in AWS S3 Back End

### Terraform Backends
* Determines how the state is stored.
* By default, state is stored on the local disk.
* Variables cannot be used as input to Terraform.

### Configuring an S3 Backend with Terraform

>aws s3api create-bucket --bucket <bucket.nameXX>
>vim backend.tf

**Backend Configuration:**

>terraform {
  >required_version = ">=0.12.0"
  >backend "s3" {
    >region   = "us-east-1"
    >profile  = "default"
    >key      = "terraformstatefile"
    >bucket   = "<s3bucketname>"
  }
}
**Initialize and format the code:**

>terraform init
>terraform fmt
>cat backend.tf

### Setting Up Multiple AWS Providers in Terraform**

- **Terraform Providers**
* Source Code for Terraform Resources
* Providers interact with vendor APIs (e.g., AWS, Azure) and manage resources in Terraform.
* Use the parameter **Alias** for multiple AWS providers.

_ **Declare Multiple AWS Providers**
**_Create a variable file_**
>vim variables.tf

**_Variables Configuration:_**
>variable "profile" {
  >type    = string
  >default = "default"
}

>variable "region-master" {
  >type    = string
  >default = "us-east-1"
}

>variable "region-worker" {
  >type    = string
  >default = "us-west-2"
}

**_Create a provider block file:_**
>vim providers.tf

**_Providers Configuration:_**
provider "aws" {
  profile = var.profile
  region  = var.region-master
  alias   = "region-master"
}

provider "aws" {
  profile = var.profile
  region  = var.region-worker
  alias   = "region-worker"
}

**Note:**
Run terraform init after any changes to modules or providers.
Check the .terraform/ directory for provider usage.


### Network Setup
### Deploying VPCs, Internet GWs, and Subnets

**Terraform Modules**
* Utilize Terraform modules for modular infrastructure provisioning.
* Modules encapsulate reusable components for VPC, Internet GWs, and Subnets.

**VPC Setup:**
Define VPC configuration using Terraform.
Specify parameters such as CIDR blocks, tenancy, and DNS support.

**Internet Gateway Deployment:**
* Provision Internet Gateways for VPC connectivity.
* Associate Internet Gateways with the VPC.

**Subnet Configuration:**
* Deploy Subnets within the VPC.
* Define Subnet attributes like CIDR blocks and availability zones.

### App VM Deployment: Using Data Source for AMI IDs and Key Pair Deployment
**Fetching AMI IDs**

 **_Data Source Usage:_**
  * Employ Data Source (SSM Parameter Store) to fetch AMI IDs dynamically.
  * Enhance flexibility by avoiding hardcoding AMI values.

### App VM Deployment: Deploying Key Pairs for App Nodes
**_Key Pair Management:_**
  * Utilize Terraform to deploy SSH key pairs for secure access to App Nodes.
  * Implement secure communication between instances.

### App VM Deployment: Jenkins Deployment
**Deploying Jenkins Master and Worker Instances**

**_Configuration Management:_**
  * Integrate Ansible for configuring Jenkins Master and Worker instances.
  * Utilize Ansible playbooks to define and manage configurations.

**_Provisioning with Terraform:_**
  * Combine Terraform and Ansible for seamless Jenkins deployment.
  * Leverage Terraform to provision infrastructure and Ansible for detailed configuration.

### Configuring Terraform Provisioners for Ansible
**_Integration Process:_**
  * Establish communication between Terraform and Ansible.
  * Configure Terraform provisioners to invoke Ansible playbooks for further configuration.

### Load Balancing
**Creating an Application Load Balancer (ALB)**

**_Load Balancer Setup:_**
  * Use Terraform to create an Application Load Balancer (ALB).
  * Route traffic efficiently to EC2 App Nodes.

### DNS Setup
**Setting up HTTPS and a Route 53 Record**

**_Secure Communication:_**
  * Implement HTTPS for secure data transfer.
  * Configure a Route 53 Record for DNS resolution.

### Terraform Outputs and Visualization

**_Output Configuration:_**
  * Utilize Terraform outputs to display essential information after deployment.
  * Enhance visibility and obtain critical details for further operations.

**_Graphical Representation:_**
  * Leverage Terraform Graph to visualize the infrastructure topology.
  * Understand dependencies and relationships between components.
## Ansible Configuration Management
### Playbooks and Templates

**_Syntax Checking:_**
* Implement Ansible Playbooks for defining infrastructure configurations.
* Utilize syntax checking to ensure playbook correctness.

**_Jenkins Configuration:_**
* Develop Playbooks for Jenkins Master and Worker setup.
* Utilize Jinja2 Templates for dynamic configuration generation.
## WHEN COMBINING IAC AND CONFIG MANAGMT 
### Verification and Troubleshooting

**_Validation Process:_**
  * Verify Infrastructure as Code (IaC) code using Terraform.
  * Ensure accurate deployment and configuration.

**_Troubleshooting Techniques:_**
  * Implement logging mechanisms such as TF_LOG and ANSIBLE_DEBUG for issue identification.
  * Troubleshoot common problems during setup and execution.

## KEY TAKEAWAYS
### Terraform & IaC
**How does Terraform make it easier to handle AWS resources like a pro?**
Terraform simplifies AWS resource management through a declarative syntax, automation of provisioning (creating and managing inf resources), and ensuring consistent deployments.
  _Essentialy, you can describe your desired infrastructure in a declarative manner. Instead of specifying step-by-step instructions on how to create resources and then Terraform figures out the steps to achieve that state. It also automates the creation and management of insfrastructure resources and makes sure you can use the same configuration to deploy across different environments once you have defined your infrastructure._
  _Terraform promotes the concept of "immutable infrastructure," where instead of making changes to existing infrastructure, you create new instances with the desired changes and replace the old ones; enhancing reliability and reducing the risk of configuration drift._

### Ansible
**How does Ansible help configure AWS stuff seamlessly?**
Ansible simplifies AWS configuration with YAML-based playbooks, automating infrastructure setup and promoting seamless configurations.
  _Ansible playbooks easy to read, write, and understand._
  _Playbooks in Ansible define a series of tasks to be executed on target machines, allowing you to automate tasks such as software installation, configuration file management, and service deployment._
  _They also provide a consistent and repeatable way to configure AWS resources, ensuring that the desired state is achieved across different instances or environments._

### Terraform & Ansible Integration
**Can you imagine a situation where using both Terraform and Ansible would make your AWS life easier?**
Yes, integrating Terraform for provisioning and Ansible for configuration ensures a comprehensive and efficient AWS setup.
  **_Context:**
  _In a context where i am responsible for managing the infrastructure across multiple stages of development, including development, staging, and production. Each stage has different requirements and configurations. And my goal is to efficiently provision and configure the infrastructure for these stages on AWS._
    
  1. _I can define and provision the core infrastructure components (VPCs, subnets, security groups) for each stage using terraform. Make use of Terraform workspaces or variables to manage specific environment configurations allowing me to reuse the same Terraform codebase for different stages while also customizing variables according to the environment. Then benefit from Terraform's dependency management to ensure that resources are provisioned in the correct order, maintaining consistency and avoiding race conditions_
  2. _Using Ansible i can write Ansible playbooks to install and configure software, set up users, and perform any environment-specific configurations. Use Ansible variables to manage environment-specific configurations within playbooks, to allow me to customize configurations based on the stage (dev, staging, prod). And finally Create modular Ansible playbooks that can be reused across different stages. For example, have a generic playbook for installing common software and additional playbooks for stage-specific configurations._
  3. _With both i can have a clear Separation of Concerns because Terraform handles the infrastructure provisioning, while Ansible takes care of configuration management. Reuse Terraform modules and Ansible playbooks across different stages, minimizing duplication and ensuring consistency in configurations. Collaboration is improved between infrastructure and configuration teams. We can also easily scale the infrastructure setup to accommodate changes in the number of environments or stages. Last but not the least, i can ensure the infrastructure and configurations are consistent across different stages, reducing the chances of discrepancies between development, staging, and production._

### Multi-Environment Setup
**How would you organize your Terraform and Ansible code for different stages (dev, staging, production)?**
_Use separate directories for each stage, employ Terraform workspaces for environment variables, and utilize Ansible roles and variables for configuration management._

### Version Control
**How can tools like Git make your Terraform and Ansible game stronger?**
_Git provides version control, enabling change tracking, collaboration, and error prevention in which are all features needed when dealing with both Terraform and Ansible projects._
