# Azure CosmosDB NoSQL Deployment

Hello! This repository provides a quick and seamless way to deploy a CosmosDB NoSQL database on Azure using Terraform and Python.

## Prerequisites

- Ensure you have `Terraform` installed.
- Ensure you have `Python 3` and `pip` installed.
- Install the required Python packages: `pip3 install azure-cosmos`.

## Deployment Steps
1. Clone the repository
git clone https://github.com/Abhimanyu9988/azure-nosql-cosmos-db.git

2. **Navigate to the git clone Directory**:
    ```
    cd azure-nosql-cosmos-db
    ```

3. **Run the Deployment Script**:
    ```
    ./deploy.sh
    ```

    - This script will greet you and ask for your confirmation to proceed.
    - On confirmation, it will:
        1. Initialize and apply the Terraform configuration.
        2. Use the outputs from Terraform to set environment variables.
        3. Run the `app.py` Python script to interface with Azure CosmosDB.

3. **View Outputs**: Once the script completes successfully, you should see the database and container details printed on the console.

4. **Visit Azure Portal**: You can visit your CosmosDB on the Azure Portal [here](https://cosmos.azure.com/).

## Cleaning Up

If you wish to clean up the resources created by Terraform, you can use the `clean_all.sh` script present inside the `Terraform` directory.

```
./clean_all.sh
```


## Note

- The `app.py` script creates a database and a container in the CosmosDB account and performs some basic operations like item creation, point read, and query.
- Ensure you have the necessary permissions to execute the scripts (`chmod +x script_name.sh`).

---

**Thank you for using this CosmosDB deployment setup!** 🌟
