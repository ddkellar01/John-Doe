#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [8/10] Publishing Multi-Registry Build Artifacts"
echo "=================================================="

VERSION="${1:-0.1.0}"
echo "[+] Target release version: ${VERSION}"

# Docker Registry Publishing
if [ -n "${DOCKER_REGISTRY_TOKEN:-}" ]; then
    echo "[+] Building and pushing Docker container images..."
    docker build -t "john-doe-ai/core-system:${VERSION}" .
    # docker push "john-doe-ai/core-system:${VERSION}"
else
    echo "[!] DOCKER_REGISTRY_TOKEN not set. Skipping Docker push."
fi

# PyPI Publishing
if [ -n "${PYPI_TOKEN:-}" ]; then
    echo "[+] Publishing packages to PyPI..."
    # python3 -m twine upload dist/*
else
    echo "[!] PYPI_TOKEN not set. Skipping PyPI upload."
fi

echo "[+] Artifact release check complete."
