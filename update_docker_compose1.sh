#!/bin/bash

# Variables
REPO_URL="https://<token>@github.com/paulahakeem/docker-abi"
CLONE_DIR="/tmp/docker-abi"
DOCKER_COMPOSE_TEMPLATE="docker-compose.yaml"
DOCKER_COMPOSE_FILE="docker-compose.yaml"
BRANCH_NAME="update-db-host"

# Fetch the MySQL private IP from Terraform output
# MYSQL_PRIVATE_IP=$(terraform output -raw mysql_private_ip)
MYSQL_PRIVATE_IP=$(cat instance_ip.txt)

# Remove existing clone directory if it exists
if [ -d "$CLONE_DIR" ]; then
  rm -rf "$CLONE_DIR"
fi

# Clone the repository
git clone "$REPO_URL" "$CLONE_DIR"
cd "$CLONE_DIR" || exit

# Check if branch already exists on remote
if git ls-remote --heads "$REPO_URL" "$BRANCH_NAME" | grep -q "$BRANCH_NAME"; then
  # Branch exists, delete it
  git push --delete origin "$BRANCH_NAME"
fi

# Check out a new branch
git checkout -b "$BRANCH_NAME"

# Replace the placeholder with the actual MySQL IP in the Docker Compose template
sed -i "s/REPLACE_WITH_MYSQL_IP/$MYSQL_PRIVATE_IP/g" "$DOCKER_COMPOSE_TEMPLATE"

# Copy the Docker Compose template to Docker Compose file
#cp "$DOCKER_COMPOSE_TEMPLATE" "$DOCKER_COMPOSE_FILE"

# Commit and push the changes
git add "$DOCKER_COMPOSE_FILE"
git commit -m "Update Docker Compose with MySQL IP $MYSQL_PRIVATE_IP"
git push origin "$BRANCH_NAME"

# Cleanup
cd /tmp || exit
rm -rf "$CLONE_DIR"
