#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [9/10] Deploying Multi-Cloud Infrastructure via Terraform"
echo "=================================================================="

INFRA_DIR="infra"

if [ -d "$INFRA_DIR" ]; then
    cd "$INFRA_DIR"
    
    if command -v terraform >/dev/null 2>&1; then
        echo "[+] Initializing Terraform multi-cloud provider configs..."
        terraform init
        
        echo "[+] Planning infrastructure rollout (AWS/GCP + Backblaze B2)..."
        terraform plan -out=tfplan
        
        # Uncomment below to execute live infrastructure creation
        # terraform apply tfplan
        echo "[+] Terraform dry-run plan completed successfully."
    else
        echo "[!] Terraform not found in PATH. Skipping infrastructure deployment."
    fi
    cd - >/dev/null
else
    echo "[!] Infrastructure directory '$INFRA_DIR' not found."
fi
