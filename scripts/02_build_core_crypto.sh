#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [2/10] Building Core Rust Engine with Cryptographic Shredder"
echo "=================================================================="

cd core-rust

echo "[+] Running cargo clippy and security lints..."
cargo clippy --all-targets --all-features -- -D warnings

echo "[+] Compiling release binary (including secure shred/wipe modules)..."
cargo build --release --all-targets

if command -v maturin >/dev/null 2>&1; then
    echo "[+] Building PyO3 Python bindings for high-speed core processing..."
    maturin develop --release
else
    echo "[!] Maturin not installed. Skipping Python bindings compilation."
fi

cd ..
echo "[+] Core Rust cryptographic build complete."
