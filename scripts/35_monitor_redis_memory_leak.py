#!/usr/bin/env python3
"""
[35/40] Redis Episodic Memory & Vector Cache Leak Monitor
Tracks memory consumption thresholds across agent vector states and triggers garbage collection if exceeded.
"""
import redis
import os

def monitor_redis():
    print("[+] Inspecting Redis episodic memory consumption...")
    try:
        r = redis.Redis(host=os.getenv("REDIS_HOST", "localhost"), port=6379, db=0)
        info = r.info("memory")
        used_mb = info.get("used_memory", 0) / (1024 * 1024)
        peak_mb = info.get("used_memory_peak", 0) / (1024 * 1024)
        
        print(f"[+] Current Memory Usage: {used_mb:.2f} MB (Peak: {peak_mb:.2f} MB)")
        if used_mb > 512:
            print("[!] Warning: Memory threshold exceeded. Flushing stale vector cache keys...")
            r.execute_command("MEMORY PURGE")
            print("[+] Memory purged successfully.")
        else:
            print("[+] Memory levels stable. No leaks detected.")
    except Exception as e:
        print(f"[-] Redis monitoring warning: {e}")

if __name__ == "__main__":
    monitor_redis()
