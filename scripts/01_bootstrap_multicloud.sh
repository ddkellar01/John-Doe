#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [1/10] Bootstrapping Multi-Cloud Environment & Dependencies"
echo "=================================================================="

# Verify required system tools
for cmd in docker terraform aws gcloud python3 rustc; do
    command -v "$cmd" >/dev/null 2>&1 || { echo "[!] Warning: Required tool '$cmd' is not installed."; }
done

# Initialize multi-cloud environment configuration
if [ ! -f .env ]; then
    echo "[+] Creating .env file from template..."
    cp .env.example .env
else
    echo "[!] .env file already exists. Preserving current secrets."
fi

echo "[+] Setting up Python virtual environment for multi-cloud manager..."
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install boto3 google-cloud-storage s3fs redis fastapi uvicorn requests pydantic

echo "[+] Multi-cloud environment bootstrap complete."
