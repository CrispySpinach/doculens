def create_shingles(text, k):
    
    # Preprocess the text
    words = text.split()

    # Create shingles
    shingles = []

    # Generate shingles of size k
    for i in range(len(words) - k + 1):
        shingles = " ".join(words[i:i+k])
        shingles.append(shingles)
        
    return shingles