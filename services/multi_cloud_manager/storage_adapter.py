import os

class MultiCloudStorageAdapter:
    def __init__(self, endpoint_url=None, access_key=None, secret_key=None):
        self.endpoint_url = endpoint_url or os.getenv("STORAGE_ENDPOINT_URL")
        self.access_key = access_key or os.getenv("STORAGE_ACCESS_KEY")
        self.secret_key = secret_key or os.getenv("STORAGE_SECRET_KEY")

    def is_configured(self) -> bool:
        return bool(self.access_key and self.secret_key)
