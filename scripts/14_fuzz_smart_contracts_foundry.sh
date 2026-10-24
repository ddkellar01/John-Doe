#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [14/20] Running Foundry Smart Contract Fuzzing Suite"
echo "=================================================================="

CONTRACT_PATH="services/blockchain_node"

if [ -d "$CONTRACT_PATH" ]; then
    cd "$CONTRACT_PATH"
    if command -v forge >/dev/null 2>&1; then
        echo "[+] Executing Foundry stateful and invariant fuzz tests (15,000 runs)..."
        forge test --fuzz-runs 15000 --gas-report
    else
        echo "[!] Foundry (forge) not detected. Skipping smart contract fuzzing."
    fi
    cd - >/dev/null
else
    echo "[!] Contract directory not found."
fi
