#!/bin/bash

# Kactus Docker Project - Debian Installation Script

set -e

echo "Starting Kactus Project Installation on Debian..."

# 1. Update System
echo "[+] Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

# 2. Install Docker & Docker Compose if not present
if ! command -v docker &> /dev/null; then
    echo "[+] Docker not found. Installing..."
    
    # Install dependencies
    sudo apt-get install -y ca-certificates curl gnupg

    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Set up the repository
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Enable Docker service
    sudo systemctl enable docker
    sudo systemctl start docker

    # Add current user to docker group
    echo "[+] Adding current user to docker group (you may need to log out and back in)..."
    sudo usermod -aG docker $USER
else
    echo "[+] Docker is already installed."
fi

# 3. Create Project Directory Structure (if running fresh)
echo "[+] Verifying project directories..."
mkdir -p services/wordpress services/phpipam services/internal_app \
         management/portainer \
         monitoring/prometheus monitoring/grafana/datasources monitoring/loki monitoring/promtail \
         security

# 4. Set Permissions
echo "[+] Setting permissions for Prometheus and Grafana volumes..."
# Note: In production you might want to be more specific with IDs, but for standard deployment:
sudo chmod -R 777 monitoring/grafana
# sudo chown -R 65534:65534 monitoring/prometheus

# 5. Start Services
echo "[+] Starting Docker containers..."
docker compose up -d --build

echo "---------------------------------------------------"
echo "Installation Complete!"
echo "Services should be accessible at:"
echo " - WordPress: http://localhost:8080"
echo " - phpIPAM: http://localhost:8081"
echo " - Internal App: http://localhost:8082"
echo " - Portainer: http://localhost:9000"
echo " - Grafana: http://localhost:3000"
echo "---------------------------------------------------"
