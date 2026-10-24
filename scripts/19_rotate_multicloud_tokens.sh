#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [19/20] Rotating Multi-Cloud Secrets & IAM Tokens"
echo "=================================================================="

ENV_FILE=".env"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -f "$ENV_FILE" ]; then
    cp "$ENV_FILE" ".env.bak_${TIMESTAMP}"
    echo "[+] Backup created: .env.bak_${TIMESTAMP}"
    
    # Generate new secure tokens
    NEW_STORAGE_KEY=$(openssl rand -hex 32)
    NEW_JWT_SECRET=$(openssl rand -hex 48)
    
    # Update environment variables safely
    sed -i.tmp "s/^STORAGE_SECRET_KEY=.*/STORAGE_SECRET_KEY=${NEW_STORAGE_KEY}/" "$ENV_FILE"
    sed -i.tmp "s/^JWT_SECRET=.*/JWT_SECRET=${NEW_JWT_SECRET}/" "$ENV_FILE"
    rm -f "${ENV_FILE}.tmp"
    
    echo "[+] Multi-cloud storage keys and JWT secrets rotated successfully."
else
    echo "[!] Error: .env configuration file missing."
    exit 1
fi
