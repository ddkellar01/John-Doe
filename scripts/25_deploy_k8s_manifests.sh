#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [25/30] Deploying Kubernetes Cluster Manifests"
echo "=================================================================="

K8S_DIR="infra/k8s"

if [ -d "$K8S_DIR" ]; then
    if command -v kubectl >/dev/null 2>&1; then
        echo "[+] Applying Kubernetes microservice manifests..."
        kubectl apply -f "$K8S_DIR/deployment.yaml"
        kubectl apply -f "$K8S_DIR/ingress.yaml"
        echo "[+] Kubernetes rollout successfully initiated."
    else
        echo "[!] kubectl not detected in PATH. Skipping cluster deployment."
    fi
else
    echo "[!] Kubernetes manifest directory '$K8S_DIR' not found."
fi
