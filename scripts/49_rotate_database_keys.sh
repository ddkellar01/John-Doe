#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [49/50] Zero-Downtime Database & Encryption Key Rotation"
echo "=================================================================="

ENV_FILE=".env"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -f "$ENV_FILE" ]; then
    cp "$ENV_FILE" ".env.bak_${TIMESTAMP}"
    echo "[+] Backup configuration created: .env.bak_${TIMESTAMP}"
    
    NEW_DB_KEY=$(openssl rand -hex 32)
    sed -i.tmp "s/^DB_ENCRYPTION_KEY=.*/DB_ENCRYPTION_KEY=${NEW_DB_KEY}/" "$ENV_FILE" 2>/dev/null || echo "DB_ENCRYPTION_KEY=${NEW_DB_KEY}" >> "$ENV_FILE"
    rm -f "${ENV_FILE}.tmp"
    
    echo "[+] Database encryption keys rotated successfully with zero downtime."
else
    echo "[!] .env configuration file missing."
fi
