#!/bin/bash

echo "Rolling back deployment..."

docker stop hrms-production || true
docker rm hrms-production || true

docker run -d \
    --name hrms-production \
    -p 80:8000 \
    mounikavakacharlla/hrms:latest

echo "Rollback completed."
