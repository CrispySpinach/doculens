#pragma once

#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>

struct Document
{
    std::string fileName;
    std::string content;
};

struct ComparisonResult
{
    std::string fileName;
    double similarity;
};

class document_comparator
{
public:
    double compare(
        const std::string& doc1,
        const std::string& doc2,
        int shingle_size = 3
    );

    std::vector<ComparisonResult>
    compareMultiple(
        const std::string& referenceDoc,
        const std::vector<Document>& documents,
        int shingleSize = 3
    );

private:
    static constexpr long long BASE = 257;
    static constexpr long long MOD = 1000000007LL;

    std::string preprocess(
        const std::string& text
    );

    std::vector<std::string> createShigles(
        const std::string& text,
        int k
    );

    long long rabinHash(
        const std::string& text
    );

    std::unordered_map<
        long long,
        std::vector<std::string>
    > buildHashIndex(
        const std::vector<std::string>& shingles
    );

    std::unordered_set<std::string>
    findVerifiedMatches(
        const std::unordered_map<
            long long,
            std::vector<std::string>
        >& indexA,

        const std::unordered_map<
            long long,
            std::vector<std::string>
        >& indexB
    );
    

    double calculateSimilarity(
        const std::vector<std::string>& shinglesA,
        const std::vector<std::string>& shinglesB,
        const std::unordered_set<std::string>& matches
    );
};