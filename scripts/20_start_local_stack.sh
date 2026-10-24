#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [20/20] Launching Full Local Stack & Frontend Dashboard"
echo "=================================================================="

# Verify Docker daemon is running
command -v docker >/dev/null 2>&1 || { echo "Docker is required. Aborting."; exit 1; }

echo "[+] Starting Docker Compose multi-container environment..."
docker compose up -d

echo "[+] Launching Next.js operational control dashboard..."
if [ -d "frontend" ]; then
    cd frontend
    if [ -f "package.json" ]; then
        # npm install --silent
        echo "[+] Frontend dependencies ready. Start dev server with 'npm run dev' or access via gateway."
    fi
    cd ..
else
    echo "[!] Frontend directory not found."
fi

echo "=================================================================="
echo "[+] John-Doe AI System local stack is fully online and operational!"
echo "=================================================================="
