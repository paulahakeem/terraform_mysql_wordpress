# WordPress Deployment on AWS with Docker, Nginx, and Terraform

This project automates the setup of a scalable and highly available WordPress deployment on AWS using Docker containers orchestrated with Docker Compose, Nginx as a load balancer, and Terraform for infrastructure provisioning.

## Requirements

1. **Create an EC2 Machine and Install Docker**
2. **Create a Docker Compose File with the Following Requirements:**
   - Use the WordPress image.
   - Run 2 containers of WordPress on 2 different ports consecutively (the 1st instance must be up and healthy before starting the 2nd instance).
   - Use a MySQL database on a different EC2 machine.
3. **Create an Nginx Load Balancer to Balance Traffic Between the 2 WordPress Instances**
4. **Create an AMI from the EC2 Machine and Add it to Your Launch Template**
5. **Ensure that `wp-content/uploads` Directory is Persistent**
6. **Add 1 Machine to Your Auto Scaling Group**

## Expected Output

A machine in your auto-scaling group with Nginx forwarding traffic to 2 WordPress containers that are linked to the MySQL database. The files in `wp-content/uploads` should always be present when containers get replaced.

## Setup Instructions

### 1. Create EC2 Instances

1. **Network Setup**:
   - Configure VPC, subnets, and security groups using the provided Terraform module `network`.

2. **MySQL Database EC2**:
   - Launch an EC2 instance for the MySQL database using the provided Terraform module `frontendEC2`.
   - Install MySQL and set up the WordPress database using the `mysql_installation.sh` script.

### 2. Setup MySQL Database

- Ensure MySQL is running and configured to allow remote connections.
- Note down the private IP address of the MySQL instance.

### 3. Configure Docker and Docker Compose

1. **Docker Installation**:
   - Install Docker and Docker Compose on the EC2 instance using the `TEMPLATE_installation.sh` script.

2. **Update Docker Compose**:
   - Use the `update_docker_compose.sh` script to dynamically update the Docker Compose file with the MySQL database IP.

### 4. Create AMI and Launch Template

- Create an AMI from the EC2 instance and add it to your launch template using the provided Terraform module `lunch_template`.

### 5. Setup Auto Scaling Group

- Set up an Auto Scaling Group with the created launch template to ensure high availability and scalability using the provided Terraform module `ASG`.

## Usage

- Access the WordPress site through the DNS link provided by the load balancer output in Terraform.
- Verify that the `wp-content/uploads` directory remains persistent across container replacements.

## Detailed Explanation of `update_docker_compose.sh`

The `update_docker_compose.sh` script performs the following tasks:
1. **Clones the Repository**: It clones the GitHub repository containing the Docker Compose template.
2. **Fetches MySQL IP**: It fetches the private IP address of the MySQL instance from a file.
3. **Updates Docker Compose File**: It replaces a placeholder in the Docker Compose template with the actual MySQL IP address.
4. **Commits and Pushes Changes**: It commits the updated Docker Compose file to a new branch and pushes the changes to the GitHub repository.

This script ensures that the Docker Compose file always has the correct MySQL IP address, allowing the WordPress containers to connect to the database without manual intervention.

## Contributing

To contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.


---

Repository used: [paulahakeem/docker-abi](https://github.com/paulahakeem/docker-abi/)
