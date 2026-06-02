#include "../include/document_comparator.h"

extern "C"
{
    __declspec(dllexport)
    double compareDocuments(
        const char* docA,
        const char* docB,
        int shingleSize
    )
    {
        document_comparator comparator;

        return comparator.compare(
            docA,
            docB,
            shingleSize
        );
    }
}