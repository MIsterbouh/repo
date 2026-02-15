#!/bin/bash

# Trivy Security Scan Script for Debian

IMAGES=(
    "wordpress:latest"
    "mariadb:10.6"
    "phpipam/phpipam-www:latest"
    "portainer/portainer-ce:latest"
    "prom/prometheus:latest"
    "grafana/grafana:latest"
    "grafana/loki:latest"
    "grafana/promtail:latest"
)

echo "Starting Trivy Security Scan..."

# Check if Trivy is installed, if not, use Docker version
if command -v trivy &> /dev/null; then
    echo "Using installed Trivy..."
    USE_DOCKER=false
else
    echo "Trivy not installed. Using aquasec/trivy Docker image..."
    USE_DOCKER=true
fi

for image in "${IMAGES[@]}"; do
    echo "Scanning $image..."
    
    if [ "$USE_DOCKER" = true ]; then
        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
            -v $HOME/.cache/trivy:/root/.cache/trivy \
            aquasec/trivy image --severity HIGH,CRITICAL "$image"
    else
        trivy image --severity HIGH,CRITICAL "$image"
    fi
done

echo "Scan Complete."
