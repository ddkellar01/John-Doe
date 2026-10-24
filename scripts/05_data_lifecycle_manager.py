#!/usr/bin/env python3
"""
[5/10] User Preference & Data Lifecycle Manager
Handles liking (pinning/replication), disliking (cold archival), and categorization.
"""
import redis
import os
import json

r = redis.Redis(host=os.getenv("REDIS_HOST", "localhost"), port=6379, db=0)

def process_user_preference(project_id: str, preference: str):
    """
    preference: 'like', 'dislike', 'pin'
    """
    key = f"preference:project:{project_id}"
    r.set(key, preference)
    
    if preference in ["like", "pin"]:
        print(f"[+] Project {project_id} marked as {preference}. Replicating across primary & backup clouds.")
        # Trigger multi-cloud replication workflow
    elif preference == "dislike":
        print(f"[+] Project {project_id} marked as dislike. Moving to cold archival storage.")
        # Trigger migration to Backblaze B2 cold tier
        
if __name__ == "__main__":
    # Example simulation
    process_user_preference("project_0042_microservice_rust", "pin")
    process_user_preference("project_0108_smart_contract_solidity", "dislike")
