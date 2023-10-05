#!/bin/bash

echo -e "${GREEN}Deploying Terraform!!"
# Run Terraform commands
terraform init
terraform apply -auto-approve

echo -e "${GREEN}${BOLD}Congratulations!!${RESET} Your Terraform is successfully deployed."
echo -e "${BOLD}Let's deploy the Application now"
sleep 500
# Extract outputs from Terraform
COSMOS_ENDPOINT=$(terraform output COSMOSDB_ENDPOINT)
COSMOS_KEY=$(terraform output COSMOSDB_PRIMARY_MASTER_KEY)
DATABASE_NAME=$(terraform output DATABASE_NAME)
CONTAINER_NAME=$(terraform output CONTAINER_NAME)

# Change to directory containing the Python script
cd ..

# Provide the values as environment variables to Python
export COSMOS_ENDPOINT=$COSMOS_ENDPOINT
export COSMOS_KEY=$COSMOS_KEY
export DATABASE_NAME=$DATABASE_NAME
export CONTAINER_NAME=$CONTAINER_NAME

# Run the Python script
echo "Running the app now"
pip3 install azure-cosmos
pip3 install azure
sleep 60
python app.py

# Unset environment variables
unset COSMOS_ENDPOINT
unset COSMOS_KEY
unset DATABASE_NAME
unset CONTAINER_NAME


# Define some color codes
GREEN="\033[1;32m"
BOLD="\033[1m"
RESET="\033[0m"
UNDERLINE="\033[4m"

# Print enhanced messages
echo -e "${GREEN}${BOLD}Congratulations!!${RESET} Your Database is successfully deployed."
echo -e "You can visit the CosmosDB portal at ${UNDERLINE}https://cosmos.azure.com/${RESET}\n"