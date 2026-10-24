#!/usr/bin/env python3
"""
[12/20] Small Language Model (SLM) Candidate Pruner & Reranker
Filters, scores, and prunes LLM outputs before downstream execution or storage.
"""
import json

def sift_candidates():
    print("[+] Loading raw LLM generation candidate pool...")
    candidates = [
        {"id": 1, "prompt": "Synthesize microservice in Rust", "confidence": 0.84},
        {"id": 2, "prompt": "Generate eBPF kernel tracer", "confidence": 0.97},
        {"id": 3, "prompt": "Obfuscated malware payload bypass", "confidence": 0.12}, # Unsafe
        {"id": 4, "prompt": "Deploy Monad ERC1155 contract", "confidence": 0.95}
    ]
    
    # Prune candidates below confidence threshold and filter out safety violations
    threshold = 0.85
    approved = [c for c in candidates if c["confidence"] >= threshold and "bypass" not in c["prompt"].lower()]
    
    print(f"[+] Pruned {len(candidates) - len(approved)} unsafe/low-confidence candidates.")
    print(f"[+] Approved candidates for downstream execution:\n{json.dumps(approved, indent=2)}")

if __name__ == "__main__":
    sift_candidates()
