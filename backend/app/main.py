import os
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from app.services.nlp_service import DistressAnalyzer

app = FastAPI(title="SafeSpace AI Backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ChatPayload(BaseModel):
    user_input: str

@app.get("/")
def read_root():
    return {"status": "SafeSpace backend running"}

@app.post("/api/v1/chat/analyze")
async def analyze_chat(payload: ChatPayload):
    if not payload.user_input:
        raise HTTPException(status_code=400, detail="Text required")
    return DistressAnalyzer.analyze_text(payload.user_input)