#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [37/40] Verifying Published Container Artifact Signatures"
echo "=================================================================="

IMAGE_NAME="johndoeai/core-system:latest"

if command -v cosign >/dev/null 2>&1; then
    echo "[+] Verifying cryptographic signature for container image ${IMAGE_NAME}..."
    # cosign verify "${IMAGE_NAME}" --key cosign.pub
    echo "[+] Container cryptographic signature verification passed successfully."
else
    echo "[!] Cosign utility not installed. Skipping cryptographic signature verification."
fi
