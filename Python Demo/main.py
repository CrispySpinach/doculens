from services.preprocessor import preprocess_text
from services.shingler import create_shingles
from services.BuildHashIndex import build_hash_index
from services.similarity import (
    find_verified_matches,
    jaccard_similarity
)

doc1 = """
The quick brown fox jumps over the lazy dog
"""

doc2 = """
The quick brown fox leaps over the lazy dog
"""

doc1 = preprocess_text(doc1)
doc2 = preprocess_text(doc2)

shingles1 = create_shingles(doc1, k=3)
shingles2 = create_shingles(doc2, k=3)

index1 = build_hash_index(shingles1)
index2 = build_hash_index(shingles2)

verified_matches = find_verified_matches(
    index1,
    index2
)

similarity = jaccard_similarity(
    shingles1,
    shingles2,
    verified_matches
)

print(f"Similarity: {similarity:.2f}%")