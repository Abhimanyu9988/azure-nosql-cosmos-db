#!/bin/bash

# Define some color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Greet the user
username=$(whoami)
echo -e "${GREEN}Hello $username!!${RESET} We will be deploying a CosmosDB NoSQL database"

# Prompt the user for input
echo -en "${YELLOW}Proceed? (yes or no) ${RESET}"

# Read input with a timeout of 10 seconds
read -t 10 answer

# Check the result of the last command (read)
if [ $? != 0 ]; then
    echo -e "${RED}\nNo input was given.${RESET}"
    echo -e "${BLUE}Goodbye!${RESET}"
    exit 1
fi

# Check the user's answer
case $answer in
    [yY] | [yY][eE][sS])
        echo -e "${GREEN}Proceeding...${RESET}"
        # Change to the Terraform directory
        cd Terraform
        # Check if cd command was successful
        if [ $? -ne 0 ]; then
            echo -e "${RED}Error navigating to Terraform directory.${RESET}"
            echo -e "${BLUE}Goodbye!${RESET}"
            exit 1
        fi
        # Run the run_all.sh script
        ./run_all.sh
        if [ $? -ne 0 ]; then
            echo -e "${RED}Error executing run_all.sh.${RESET}"
            echo -e "${BLUE}Goodbye!${RESET}"
            exit 1
        fi
        ;;
    [nN] | [nN][oO])
        echo -e "${BLUE}Goodbye!${RESET}"
        exit 1
        ;;
    *)
        echo -e "${RED}Invalid input${RESET}"
        echo -e "${BLUE}Goodbye!${RESET}"
        exit 1
        ;;
esac
