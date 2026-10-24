#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [1/10] Bootstrapping John-Doe AI System Environment"
echo "=================================================="

# Verify prerequisites
command -v docker >/dev/null 2>&1 || { echo "Docker is required but not installed. Aborting."; exit 1; }
command -v rustc >/dev/null 2>&1 || { echo "Rust toolchain is required but not installed. Aborting."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "Python 3 is required but not installed. Aborting."; exit 1; }

# Initialize environment configuration
if [ ! -f .env ]; then
    echo "[+] Creating .env file from template..."
    cp .env.example .env
else
    echo "[!] .env file already exists. Skipping copy."
fi

# Create virtual environment and install base dependencies
echo "[+] Setting up Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

echo "[+] Bootstrapping complete."
