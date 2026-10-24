#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [47/50] Running Criterion Benchmarks for Core-Rust Engine"
echo "=================================================================="

if [ -d "core-rust" ]; then
    cd core-rust
    if cargo --list | grep -q "bench"; then
        echo "[+] Executing micro-benchmarks for memory-safe AST parsing and eBPF tracing..."
        cargo bench
    else
        echo "[!] Cargo bench profile not explicitly configured. Running release integration test..."
        cargo test --release
    fi
    cd - >/dev/null
else
    echo "[!] core-rust directory not found."
fi
