name: John-Doe AI System Master CI/CD Pipeline

on:
  push:
    branches: [ "main", "dev" ]
  pull_request:
    branches: [ "main", "dev" ]

jobs:
  build_and_test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Upgrade Pip & Install Dependencies
        run: |
          python -m pip install --upgrade pip setuptools wheel
          if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

      - name: Run Vault & Core Verification Scripts
        run: |
          python3 -c "print('John-Doe Pipeline Initialized Successfully')"
          if [ -f scripts/04_generate_code_vault.py ]; then python3 scripts/04_generate_code_vault.py; fi
          if [ -f scripts/26_verify_cryptographic_shred.py ]; then python3 scripts/26_verify_cryptographic_shred.py; fi
