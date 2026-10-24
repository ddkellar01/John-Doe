#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [7/10] Running Foundry Smart Contract Fuzzer"
echo "=================================================="

CONTRACT_DIR="services/blockchain_node"

if [ -d "$CONTRACT_DIR" ]; then
    cd "$CONTRACT_DIR"
    if command -v forge >/dev/null 2>&1; then
        echo "[+] Executing Forge invariant and stateful fuzz tests..."
        forge test --fuzz-runs 10000 --verbosity 2
    else
        echo "[!] Foundry (forge) not detected in PATH. Skipping smart contract fuzzing."
    fi
    cd - >/dev/null
else
    echo "[!] Contract directory '$CONTRACT_DIR' not found. Skipping."
fi
