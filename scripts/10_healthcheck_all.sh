#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [10/10] Full System Microservice Health Check"
echo "=================================================="

SERVICES=(
    "http://localhost:8000/health" # Orchestrator
    "http://localhost:8001/health" # Scraper Scout
    "http://localhost:8002/health" # Tester Sandbox
    "http://localhost:8003/health" # Monetization Proxy
)

for URL in "${SERVICES[@]}"; do
    echo -n "[+] Checking endpoint ${URL}... "
    if command -v curl >/dev/null 2>&1; then
        HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || echo "000")
        if [ "$HTTP_CODE" -eq 200 ]; then
            echo "OK (200)"
        else
            echo "UNREACHABLE/OFFLINE (HTTP $HTTP_CODE)"
        fi
    else
        echo "curl not installed, skipping network check."
    fi
done

echo "=================================================="
echo "[+] Health check run completed."
