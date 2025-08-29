
import subprocess
import time
import requests
from requests.adapters import HTTPAdapter, Retry
import runpod
import os

# Start the FastAPI server in the background
subprocess.Popen(["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"])

# Wait for the server to start
time.sleep(5)

def handler(job):
    """
    This is the handler function that will be called by RunPod.
    """
    job_input = job["input"]

    # Call the FastAPI endpoint
    session = requests.Session()
    retries = Retry(total=3, backoff_factor=0.1, status_forcelist=[500, 502, 503, 504])
    session.mount('http://', HTTPAdapter(max_retries=retries))

    response = session.post("http://127.0.0.1:8000/talk", json=job_input, timeout=600)

    return response.json()

if __name__ == "__main__":
    runpod.serverless.start({"handler": handler})
