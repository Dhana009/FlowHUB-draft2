import json

# Read the exported documents
with open('exported_documents.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

docs = data.get('documents', [])
print(f"Total documents: {len(docs)}")

# Find documents with "unknown" or missing category
unknown_docs = []
for doc in docs:
    category = doc.get('meta', {}).get('category')
    if category == 'unknown' or category is None or category == '':
        unknown_docs.append(doc)

print(f"\nDocuments with 'unknown' or missing category: {len(unknown_docs)}")

# Print details of each unknown document
for i, doc in enumerate(unknown_docs, 1):
    meta = doc.get('meta', {})
    print(f"\n--- Document {i} ---")
    print(f"ID: {doc['id'][:50]}...")
    print(f"Category: {meta.get('category', 'MISSING/NULL')}")
    print(f"File Path: {meta.get('file_path', 'N/A')}")
    print(f"Doc ID: {meta.get('doc_id', 'N/A')}")
    print(f"Type: {meta.get('type', 'N/A')}")
    print(f"Content preview: {doc.get('content', '')[:100]}...")

