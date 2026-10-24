#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [4/10] Rotating API Keys & System Credentials"
echo "=================================================="

ENV_FILE=".env"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -f "$ENV_FILE" ]; then
    echo "[+] Creating backup of current .env -> .env.bak_${TIMESTAMP}"
    cp "$ENV_FILE" ".env.bak_${TIMESTAMP}"

    # Generate new random secure secrets for internal services
    NEW_JWT_SECRET=$(openssl rand -hex 32)
    NEW_INTERNAL_API_KEY=$(openssl rand -hex 24)

    # Update secret keys in .env
    sed -i.tmp "s/^JWT_SECRET=.*/JWT_SECRET=${NEW_JWT_SECRET}/" "$ENV_FILE"
    sed -i.tmp "s/^INTERNAL_API_KEY=.*/INTERNAL_API_KEY=${NEW_INTERNAL_API_KEY}/" "$ENV_FILE"
    rm -f "${ENV_FILE}.tmp"

    echo "[+] JWT_SECRET and INTERNAL_API_KEY rotated successfully."
else
    echo "[!] Error: .env file not found."
    exit 1
fi
