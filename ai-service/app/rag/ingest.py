from .chroma_client import collection
from .embeddings import generate_embedding
import uuid

def chunk_text(text, chunk_size=500):
    return [text[i:i+chunk_size] for i in range(0, len(text), chunk_size)]

def ingest_document(tittle: str, content: str, source: str):
    chunks = chunk_text(content)

    for chunk in chunks:
        embedding = generate_embedding(chunk)

        collection.add(
            documents=[chunk],
            embeddings=[embedding],
            metadatas=[{
                "title": tittle,
                "source": source
            }],
            ids=[str(uuid.uuid4())]
        )
