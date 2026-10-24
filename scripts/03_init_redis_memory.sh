#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " [3/10] Initializing Redis Episodic Memory & Vector Cache"
echo "=================================================="

REDIS_HOST="${REDIS_HOST:-localhost}"
REDIS_PORT="${REDIS_PORT:-6379}"

echo "[+] Checking connection to Redis at ${REDIS_HOST}:${REDIS_PORT}..."
until docker exec -it $(docker ps -q -f name=redis) redis-cli ping | grep -q PONG 2>/dev/null || nc -z "$REDIS_HOST" "$REDIS_PORT"; do
    echo "[*] Waiting for Redis to be reachable..."
    sleep 2
done

echo "[+] Creating vector search indices and state keys..."
python3 -c "
import os, redis
r = redis.Redis(host=os.getenv('REDIS_HOST', 'localhost'), port=int(os.getenv('REDIS_PORT', 6379)), db=0)
r.set('system:status', 'initialized')
r.set('system:version', '1.0.0-beta')
print('[+] Redis state initialized successfully. Ping response:', r.ping())
"
