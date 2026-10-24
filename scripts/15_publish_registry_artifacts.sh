#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [15/20] Publishing Multi-Registry Release Artifacts"
echo "=================================================================="

VERSION="${1:-1.0.0}"
echo "[+] Target publication version: ${VERSION}"

# Docker Hub Multi-Arch Container Publish
if [ -n "${DOCKER_USER:-}" ]; then
    echo "[+] Building and pushing multi-arch container images to Docker Hub..."
    docker buildx build --platform linux/amd64,linux/arm64 -t "johndoeai/core-system:${VERSION}" --push .
else
    echo "[!] Docker credentials not provided. Skipping container push."
fi

# Crates.io Rust Package Publish
if [ -d "core-rust" ] && [ -n "${CARGO_REGISTRY_TOKEN:-}" ]; then
    echo "[+] Publishing core-rust crate to crates.io..."
    cd core-rust && cargo publish --token "${CARGO_REGISTRY_TOKEN}" && cd ..
else
    echo "[!] Crates token missing or core-rust absent. Skipping crate publish."
fi

echo "[+] Multi-registry artifact publishing cycle completed."
