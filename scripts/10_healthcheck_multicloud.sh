#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [10/10] Full Multi-Cloud & Microservice Health Check"
echo "=================================================================="

ENDPOINTS=(
    "http://localhost:8000/health" # Orchestrator
    "http://localhost:8001/health" # Scraper Scout
    "http://localhost:8002/health" # Code Generator Vault
    "http://localhost:8003/health" # Multi-Cloud Manager
    "http://localhost:8004/health" # Data Lifecycle & Purge
)

for URL in "${ENDPOINTS[@]}"; do
    echo -n "[+] Checking endpoint ${URL}... "
    if command -v curl >/dev/null 2>&1; then
        HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")
        if [ "$HTTP_CODE" -eq 200 ]; then
            echo "ONLINE (200)"
        else
            echo "OFFLINE/UNREACHABLE (HTTP $HTTP_CODE)"
        fi
    else
        echo "curl missing, skipping."
    fi
done

echo "=================================================================="
echo "[+] Multi-cloud health verification complete."
