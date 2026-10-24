#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [30/30] System Diagnostic Deep Clean & Garbage Collection"
echo "=================================================================="

echo "[+] Pruning unused Docker containers, networks, and build caches..."
if command -v docker >/dev/null 2>&1; then
    docker system prune -f --volumes
else
    echo "[!] Docker not found. Skipping container garbage collection."
fi

echo "[+] Cleaning temporary Python bytecode and test artifacts..."
find . -type f -name "*.pyc" -delete
find . -type d -name "__pycache__" -exec rm -r {} + 2>/dev/null || true

echo "[+] Cleaning temporary build caches in core-rust..."
if [ -d "core-rust" ]; then
    cd core-rust && cargo clean --release && cd ..
fi

echo "=================================================================="
echo "[+] System deep clean finished. All workspaces optimized and ready."
echo "=================================================================="
