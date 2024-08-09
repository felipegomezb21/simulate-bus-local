#!/bin/bash

# Wait for Apicurio Schema Registry to be available
echo "Wait for apicurio registry to be available..."
until [[ $(curl -s http://apicurio-schema-registry:8080/health | grep -o '"status": "UP"') ]]; do
    echo '.'
    sleep 5
done

echo "Apicurio Schema Registry is available."

# Check if there are any .avsc files
SCHEMA_FILES=/avro-schemas/*.avsc
if [ -z "$(ls -A $SCHEMA_FILES 2>/dev/null)" ]; then
    echo "No .avsc files found in /schemas directory. Exiting."
    exit 1
fi

# List found schemas
echo "Found the following .avsc files:"
for SCHEMA_FILE in $SCHEMA_FILES; do
    echo "$(basename $SCHEMA_FILE)"
done

# Register each schema
for SCHEMA_FILE in $SCHEMA_FILES; do
    SCHEMA_CONTENT=$(cat $SCHEMA_FILE)
    SCHEMA_NAME=$(basename $SCHEMA_FILE .avsc)
    
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://apicurio-schema-registry:8080/apis/registry/v2/groups/default/artifacts \
        -H "Content-Type: application/json; artifactType=AVRO" \
        -H "X-Registry-ArtifactId: '$SCHEMA_NAME'" \
        -d "$SCHEMA_CONTENT")

    if [ "$RESPONSE" -eq 200 ]; then
        echo "Schema $SCHEMA_NAME created successfully."
    else
        echo "Failed to create schema $SCHEMA_NAME. HTTP response code: $RESPONSE"
    fi
done

