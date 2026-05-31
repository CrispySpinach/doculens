def jaccard_similarity(set1, set2):

    # Calculate the intersection and union of the two sets
    intersection = len(set1 & set2)

    # Calculate the union of the two sets
    union = len(set1 | set2)

    # Handle the case where both sets are empty to avoid division by zero
    if union == 0:
        return 0
    
    return (intersection / union) * 100