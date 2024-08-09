#!/bin/bash

# URL of the Kafka Connect REST API
KAFKA_CONNECT_URL="http://kafka-connect:8083/connectors"

# Check if there are any .json files
CONNECTORS_FILES=/connectors/*.json
if [ -z "$(ls -A $CONNECTORS_FILES 2>/dev/null)" ]; then
    echo "No .json files found in /connectors directory. Exiting."
    exit 1
fi

# Wait for kafka connect to be available
echo "Wait for kafka connect to be available..."
until [[ $(curl -s http://kafka-connect:8083 | grep -o '"kafka_cluster_id"') ]]; do
    echo '.'
    sleep 5
done

# List found schemas
echo "Found the following .json files:"
for CONNECTOR_FILE in $CONNECTORS_FILES; do
    echo "$(basename $CONNECTOR_FILE)"
done

# create each connector
for CONNECTOR_FILE in $CONNECTORS_FILES; do
    CONNECTOR_CONTENT=$(cat $CONNECTOR_FILE)
    CONNECTOR_NAME=$(basename $CONNECTOR_FILE .json)
    
    RESPONSE=$(curl -X POST $KAFKA_CONNECT_URL -H "Content-Type: application/json" --data "$CONNECTOR_CONTENT")

    if [[ $RESPONSE == *"$CONNECTOR_NAME"* ]]; then
      echo "Connector $CONNECTOR_NAME created successfully."
    else
      echo "Failed to create connector $CONNECTOR_NAME. HTTP response code: $RESPONSE"
    fi
done