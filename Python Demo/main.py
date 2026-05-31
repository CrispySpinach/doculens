from services.preprocessor import preprocess_text
from services.shingler import create_shingles
from services.rabin_karp import hash_shingles
from services.similarity import jaccard_similarity

doc1 = """
The quick brown fox jumps over the lazy dog
"""

doc2 = """
Different word b dawg
"""

# Preprocess the documents
doc1 = preprocess_text(doc1)
doc2 = preprocess_text(doc2)

# Create shingles and hash them
shingles1 = create_shingles(doc1, 3)
shingles2 = create_shingles(doc2, 3)

hashes1 = hash_shingles(shingles1)
hashes2 = hash_shingles(shingles2)

# Calculate Jaccard similarity
similarity = jaccard_similarity(hashes1, hashes2)

print(f"Similarity: {similarity:.2f}%")