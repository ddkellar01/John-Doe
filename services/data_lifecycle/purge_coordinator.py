import os

def execute_local_purge(target_path: str) -> bool:
    if os.path.exists(target_path):
        os.remove(target_path)
        return True
    return False
