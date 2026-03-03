import chromadb
from chromadb.config import Settings

client = chromadb.HttpClient(
    host="chromadb",
    port=8000
)

collection = client.get_or_create_collection("aria-knowledge")