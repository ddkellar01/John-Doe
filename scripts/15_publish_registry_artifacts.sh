#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo "[15/50] Multi-Registry Artifact Publisher"
echo "=================================================="

VERSION=${1:-"1.0.0"}
echo "[*] Target release version: ${VERSION}"

# 1. Docker Hub Multi-Arch Container Publishing
if [ -n "${dockerhub_username:-}" ]; then
    echo "[+] Building and pushing multi-arch container images to Docker Hub..."
    
    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -t "${dockerhub_username}/core-system:${VERSION}" \
        -t "${dockerhub_username}/core-system:latest" \
        --push .
        
    echo "[+] Docker Hub container push complete."
else
    echo "[!] dockerhub_username not set. Skipping Docker push."
fi

# 2. PyPI Python Package Publishing
if [ -n "${PYPI_TOKEN:-}" ]; then
    echo "[+] Publishing Python packages to PyPI..."
    python3 setup.py sdist bdist_wheel
    python3 -m twine upload dist/* --username "__token__" --password "${PYPI_TOKEN}"
    echo "[+] PyPI upload complete."
else
    echo "[!] PYPI_TOKEN not set. Skipping PyPI upload."
fi

# 3. Crates.io Rust Package Publishing
if [ -d "core-rust" ] && [ -n "${CARGO_REGISTRY_TOKEN:-}" ]; then
    echo "[+] Publishing core-rust crate to crates.io..."
    cd core-rust
    cargo login "${CARGO_REGISTRY_TOKEN}"
    cargo publish --allow-dirty
    cd ..
    echo "[+] Crates.io publish complete."
else
    echo "[!] Crates.io token or core-rust directory missing. Skipping crate publish."
fi

echo "=================================================="
echo "[+] Multi-registry publishing cycle completed successfully."
echo "=================================================="
