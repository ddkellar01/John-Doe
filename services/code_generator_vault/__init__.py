import json
import os
import time

def generate_blueprint(project_id: str, output_dir: str = "output_vault"):
    os.makedirs(output_dir, exist_ok=True)
    manifest = {
        "project_id": project_id,
        "timestamp": time.time(),
        "status": "generated"
    }
    filepath = os.path.join(output_dir, f"{project_id}_manifest.json")
    with open(filepath, "w") as f:
        json.dump(manifest, f, indent=2)
    return filepath

if __name__ == "__main__":
    generate_blueprint("demo_project")
