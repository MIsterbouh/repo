# Trivy Security Scan Script
$images = @(
    "wordpress:latest",
    "mariadb:10.6",
    "phpipam/phpipam-www:latest",
    "portainer/portainer-ce:latest",
    "prom/prometheus:latest",
    "grafana/grafana:latest",
    "grafana/loki:latest",
    "grafana/promtail:latest"
)

Write-Host "Starting Trivy Security Scan..." -ForegroundColor Green

foreach ($image in $images) {
    Write-Host "Scanning $image..." -ForegroundColor Yellow
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --severity HIGH,CRITICAL $image
}

Write-Host "Scan Complété." -ForegroundColor Green
