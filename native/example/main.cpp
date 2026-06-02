#include <iostream>
#include "../include/document_comparator.h"

int main()
{
    document_comparator dc;
    std::string reference =
    "The quick brown fox jumps over the lazy dog";

    std::vector<Document> docs =
    {
        {
            "paper1.pdf",
            "The quick brown fox leaps over the lazy dog"
        },

        {
            "paper2.pdf",
            "Python programming language"
        },

        {
            "paper3.pdf",
            "The quick brown fox jumps over the lazy dog"
        }
    };

    auto results =
        dc.compareMultiple(
            reference,
            docs,
            3
        );
    
    for(const auto& result : results)
    {
        std::cout
            << result.fileName
            << " -> "
            << result.similarity
            << "%"
            << std::endl;
    }
}