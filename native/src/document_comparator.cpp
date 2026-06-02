#include "../include/document_comparator.h"

#include <iostream>
#include <algorithm>
#include <regex>
#include <sstream>

std::vector<ComparisonResult>
document_comparator::compareMultiple(
    const std::string& referenceDoc,
    const std::vector<Document>& documents,
    int shingleSize
)
{
    std::vector<ComparisonResult> results;

    for(const auto& document : documents)
    {
        ComparisonResult result;

        result.fileName =
            document.fileName;

        result.similarity =
            compare(
                referenceDoc,
                document.content,
                shingleSize
            );

        results.push_back(result);
    }

    return results;
}

std::string document_comparator::preprocess(
const std::string& text
)
{
    std::string result = text;

    std::transform(
        result.begin(),
        result.end(),
        result.begin(),
        ::tolower
    );

    result = std::regex_replace(
        result,
        std::regex("[^a-z0-9\\s]"),
        ""
    );

    result = std::regex_replace(
        result,
        std::regex("\\s+"),
        " "
    );

    return result;
}

std::vector<std::string>
document_comparator::createShigles(
    const std::string& text,
    int k
)
{
    std::vector<std::string> words;
    std::vector<std::string> shingles;

    std::stringstream ss(text);
    std::string word;

    while (ss >> word)
    {
        words.push_back(word);
    }

    if (words.size() < k)
        return shingles;

    for (size_t i = 0; i <= words.size() - k; i++)
    {
        std::string shingle;

        for (int j = 0; j < k; j++)
        {
            if (j > 0)
                shingle += " ";

            shingle += words[i + j];
        }

        shingles.push_back(shingle);
    }

    return shingles;
}

long long document_comparator::rabinHash(
    const std::string& text
)
{
    long long h = 0;

    for(char c : text)
    {
        h =
            (h * BASE + c)
            % MOD;
    }

    return h;
}

std::unordered_map<
    long long,
    std::vector<std::string>
>
document_comparator::buildHashIndex(
    const std::vector<std::string>& shingles
)
{
    std::unordered_map<
        long long,
        std::vector<std::string>
    > index;

    for(const auto& shingle : shingles)
    {
        auto hash = rabinHash(shingle);
        index[hash].push_back(shingle);
    }

    return index;
}

std::unordered_set<std::string>
document_comparator::findVerifiedMatches(
    const std::unordered_map<
        long long,
        std::vector<std::string>
    >& indexA,

    const std::unordered_map<
        long long,
        std::vector<std::string>
    >& indexB
)
{
    std::unordered_set<std::string> matches;

    for(const auto& [hash, shinglesA] : indexA)
    {
        auto it = indexB.find(hash);

        if(it == indexB.end())
            continue;

        const auto& shinglesB = it->second;

        for(const auto& shingleA : shinglesA)
        {
            for(const auto& shingleB : shinglesB)
            {
                if(shingleA == shingleB)
                {
                    matches.insert(shingleA);
                }
            }
        }
    }

    return matches;
}

double document_comparator::calculateSimilarity(
    const std::vector<std::string>& shinglesA,
    const std::vector<std::string>& shinglesB,
    const std::unordered_set<std::string>& matches
)
{
    std::unordered_set<std::string> unionSet;

    unionSet.insert(
        shinglesA.begin(),
        shinglesA.end()
    );

    unionSet.insert(
        shinglesB.begin(),
        shinglesB.end()
    );

    if(unionSet.empty())
        return 0;

    return
        static_cast<double>(
            matches.size()
        )
        /
        unionSet.size()
        * 100.0;
}

double document_comparator::compare(
    const std::string& docA,
    const std::string& docB,
    int shingleSize
)
{
    auto textA =
        preprocess(docA);

    auto textB =
        preprocess(docB);

    auto shinglesA =
        createShigles(
            textA,
            shingleSize
        );

    auto shinglesB =
        createShigles(
            textB,
            shingleSize
        );

    auto indexA =
        buildHashIndex(shinglesA);

    auto indexB =
        buildHashIndex(shinglesB);

    auto matches =
        findVerifiedMatches(
            indexA,
            indexB
        );

    return calculateSimilarity(
        shinglesA,
        shinglesB,
        matches
    );
}