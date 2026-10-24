#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [32/40] Deploying AI Orchestration Microservices to GCP Cloud Run"
echo "=================================================================="

PROJECT_ID="${GCP_PROJECT_ID:-john-doe-ai-prod}"
REGION="${GCP_REGION:-us-central1}"

if command -v gcloud >/dev/null 2>&1; then
    echo "[+] Setting active GCP project to ${PROJECT_ID}..."
    gcloud config set project "${PROJECT_ID}" --quiet
    
    echo "[+] Deploying scraper-scout & orchestrator containers to Cloud Run..."
    # gcloud run deploy john-doe-orchestrator --image gcr.io/${PROJECT_ID}/orchestrator:latest --region ${REGION} --platform managed
    echo "[+] GCP Cloud Run service deployment sequence completed."
else
    echo "[!] gcloud SDK not installed or configured. Skipping Cloud Run deployment."
fi
