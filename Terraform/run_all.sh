#!/bin/bash

# Define default values
DEFAULT_DATABASE_NAME="db_with_tf"
DEFAULT_CONTAINER_NAME="cont_with_tf"

# Prompt user for database name with a 10-second timeout
read -t 15 -p "Enter the name for the database (default: $DEFAULT_DATABASE_NAME): " database_name
# Use the default value if no input was provided
database_name=${database_name:-$DEFAULT_DATABASE_NAME}

# Prompt user for container name with a 10-second timeout
read -t 15 -p "Enter the name for the container (default: $DEFAULT_CONTAINER_NAME): " container_name
# Use the default value if no input was provided
container_name=${container_name:-$DEFAULT_CONTAINER_NAME}

export DATABASE_NAME=$database_name
export CONTAINER_NAME=$container_name

echo -e "${GREEN}Deploying Terraform!!"
# Run Terraform commands
terraform init
terraform apply -auto-approve

export COSMOS_ENDPOINT=$(terraform output COSMOSDB_ENDPOINT)
export COSMOS_KEY=$(terraform output COSMOSDB_PRIMARY_MASTER_KEY)

echo -e "${GREEN}${BOLD}Congratulations!!${RESET} Your Terraform is successfully deployed."
echo -e "${BOLD}Let's deploy the Application now"
sleep 3

# Extract outputs from Terraform

# Change to directory containing the Python script
cd ..

# Run the Python script
echo "Running the app now"
pip3 install azure-cosmos
pip3 install azure
sleep 3  # Reduced this sleep for quicker response during tests. Adjust as necessary.

python3 app.py

# Unset environment variables

# Define some color codes
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"
UNDERLINE="\033[4m"

# Print enhanced messages
echo -e "${GREEN}${BOLD}Congratulations!!${RESET} Your Database is successfully deployed."
echo -e "You can visit the CosmosDB portal at ${UNDERLINE}https://cosmos.azure.com/${RESET}\n"
