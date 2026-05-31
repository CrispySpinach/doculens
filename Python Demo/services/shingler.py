def create_shingles(text, k):
    
    # Preprocess the text
    words = text.split()

    # Create shingles
    shingles = []

    # Generate shingles of size k
    for i in range(len(words) - k + 1):
        shingle = " ".join(words[i:i+k])
        shingles.append(shingle)

    return shingles