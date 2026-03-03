from fastapi import FastAPI
from pydantic import BaseModel
from app.rag.ingest import ingest_document

app = FastAPI()

class IngestRequest(BaseModel):
    title: str
    content: str
    source: str

@app.post("/ingest")
def ingest(request: IngestRequest):
    ingest_document(
        tittle=request.title,
        content=request.content,
        source=request.source
    )
    return {"status": "ingested"}