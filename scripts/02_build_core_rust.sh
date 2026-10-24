#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [2/10] Building Core Rust Engine & PyO3 Bindings"
echo "=================================================="

cd core-rust

echo "[+] Cargo checking and linting..."
cargo clippy --all-targets --all-features -- -D warnings

echo "[+] Building release binary and dynamic library..."
cargo build --release --all-targets

# Compile PyO3 bindings for Python microservices
if command -v maturin >/dev/null 2>&1; then
    echo "[+] Compiling PyO3 Python bindings via Maturin..."
    maturin develop --release
else
    echo "[!] Maturin not found in PATH. Install with 'pip install maturin' to build Python bindings."
fi

cd ..
echo "[+] Core Rust build complete."
