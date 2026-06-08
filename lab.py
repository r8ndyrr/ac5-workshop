import subprocess
from fastapi import FastAPI, HTTPException
import uvicorn

app = FastAPI()

@app.get("/{lab_name}")
def run_lab(lab_name: str):
    if any(char in lab_name for char in [";", "&", "|", "..", "/"]):
        raise HTTPException(status_code=400, detail="Invalid lab name")

    try:
        result = subprocess.run(
          ["make", lab_name], capture_output=True, text=True, check=True)
        return {"status": "success", "output": result.stdout}
    except subprocess.CalledProcessError as e:
        raise HTTPException(status_code=500, detail=f"Make failed:\n{e.stderr}")

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=5001)