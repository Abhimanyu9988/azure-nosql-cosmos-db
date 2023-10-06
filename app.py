# <imports>
import os
import json
from azure.cosmos import CosmosClient, PartitionKey, errors
# </imports>

# <environment_variables>
ENDPOINT = os.environ['COSMOS_ENDPOINT'].strip('"')
KEY = os.environ['COSMOS_KEY']

# </environment_variables>

# <create_client>
client = CosmosClient(url=ENDPOINT, credential=KEY, consistency_level='Session')
# </create_client>

database_name = os.environ["DATABASE_NAME"]
try:
    database = client.create_database(database_name)
except errors.CosmosResourceExistsError:
    database = client.get_database_client(database_name)

container_name = os.environ["CONTAINER_NAME"]
try:
    container = database.create_container(id=container_name, partition_key=PartitionKey(path="/productName"))
except errors.CosmosResourceExistsError:
    container = database.get_container_client(container_name)
except errors.CosmosHttpResponseError:
    raise

database_client = client.get_database_client(database_name)
container_client = database.get_container_client(container_name)

for i in range(1, 10):
    container_client.upsert_item({
            'id': 'item{0}'.format(i),
            'productName': 'Widget',
            'productModel': 'Model {0}'.format(i)
        }
    )

for item in container.query_items(
                query='SELECT * FROM mycontainer r WHERE r.id="item3"',
                enable_cross_partition_query=True):
    print(json.dumps(item, indent=True))