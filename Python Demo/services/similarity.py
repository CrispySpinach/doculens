# Verify matches by comparing the actual shingles, not just their hashes
def find_verified_matches(index_a, index_b):
    matches = set()

    common_hashes = (
        set(index_a.keys())
        &
        set(index_b.keys())
    )

    for h in common_hashes:

        for shingle_a in index_a[h]:

            for shingle_b in index_b[h]:

                if shingle_a == shingle_b:
                    matches.add(shingle_a)

    return matches

# Calculate Jaccard similarity based on the verified matches and the total unique shingles in both documents
def jaccard_similarity(
    shingles_a,
    shingles_b,
    verified_matches
):
    union = len(
        set(shingles_a)
        |
        set(shingles_b)
    )

    if union == 0:
        return 0

    return (
        len(verified_matches)
        / union
    ) * 100