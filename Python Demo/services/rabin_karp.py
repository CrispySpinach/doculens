BASE = 257
MOD = 10**9 + 7

def rabin_karp(text: str):
    h = 0
    for char in text:

        # Calculate the hash value using a rolling hash approach
        h = (h * BASE + ord(char)) % MOD

    return h

def hash_shingles(shingles):
    hashes = set()

    for shingle in shingles:

        # Calculate the hash for each shingle and add it to the set of hashes
        hashes.add(rabin_karp(shingle))
    
    return hashes