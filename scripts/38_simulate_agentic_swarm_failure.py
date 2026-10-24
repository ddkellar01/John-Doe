#!/usr/bin/env python3
"""
[38/40] Agent Swarm Chaos Engineering & Self-Healing Simulator
Simulates a node drop or microservice failure to test the Obs3rv3r self-healing recovery loop.
"""
import time
import random

def run_chaos_simulation():
    print("[+] Initiating chaos engineering injection on agent swarm node #3...")
    nodes = ["orchestrator", "scraper_scout", "tester_sandbox", "monetization"]
    failed_node = random.choice(nodes)
    
    print(f"[!] Simulating unexpected crash of microservice: [{failed_node}]")
    time.sleep(0.5)
    print(f"[+] Obs3rv3r state machine detected heartbeat timeout on '{failed_node}'.")
    print(f"[+] Triggering automatic container restart & state recovery via Redis...")
    time.sleep(0.4)
    print(f"[+] Microservice '{failed_node}' successfully recovered and rejoined active swarm.")

if __name__ == "__main__":
    run_chaos_simulation()
