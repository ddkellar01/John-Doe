#!/usr/bin/env bash
set -euo pipefail

echo "=================================================================="
echo " [40/40] Master Orchestration Pipeline Controller"
echo "=================================================================="

echo "[+] Executing master pipeline sequence..."
bash scripts/01_bootstrap_multicloud.sh
bash scripts/03_init_multicloud_storage.py || python3 scripts/03_init_multicloud_storage.py
python3 scripts/04_generate_code_vault.py
python3 scripts/11_run_agent_orchestrator.py
python3 scripts/16_generate_audit_report.py
bash scripts/10_healthcheck_multicloud.sh

echo "=================================================================="
echo "[+] Master Orchestration Pipeline completed with 100% success!"
echo "=================================================================="
