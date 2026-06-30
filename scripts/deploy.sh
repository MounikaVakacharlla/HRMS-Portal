#!/bin/bash

set -e

ENVIRONMENT=$1

IMAGE="mounikavakacharlla/hrms:latest"

echo "Deploying to $ENVIRONMENT..."

if [ "$ENVIRONMENT" = "staging" ]; then

    docker stop hrms-staging || true
    docker rm hrms-staging || true

    docker run -d \
        --name hrms-staging \
        -p 8000:8000 \
        --restart unless-stopped \
        $IMAGE

elif [ "$ENVIRONMENT" = "production" ]; then

    docker stop hrms-production || true
    docker rm hrms-production || true

    docker run -d \
        --name hrms-production \
        -p 80:8000 \
        --restart unless-stopped \
        $IMAGE

else
    echo "Unknown environment."
    exit 1
fi

echo "Deployment completed."
