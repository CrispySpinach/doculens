from collections import defaultdict
from .rabin_karp import rabin_karp

# Build a hash index for the shingles using the Rabin-Karp algorithm
def build_hash_index(shingles):
    hash_index = defaultdict(list)

    for shingle in shingles:
        h = rabin_karp(shingle)

        hash_index[h].append(shingle)

    return hash_index