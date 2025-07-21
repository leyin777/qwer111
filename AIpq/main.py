from fastapi import FastAPI
from extractor import router as extract_router
from generator import router as generate_router

app = FastAPI(title="AIpq")
app.include_router(extract_router, prefix="/aipqapi", tags=["Extract"])
app.include_router(generate_router, prefix="/aipqapi", tags=["Generate"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)