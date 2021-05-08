#pragma once

#if defined(_MSC_VER) || defined(WIN64) || defined(_WIN64) ||                  \
    defined(__WIN64__) || defined(WIN32) || defined(_WIN32) ||                 \
    defined(__WIN32__) || defined(__NT__)
#define LLI_DECL_EXPORT __declspec(dllexport)
#define LLI_DECL_IMPORT __declspec(dllimport)
#else
#define LLI_DECL_EXPORT __attribute__((visibility("default")))
#define LLI_DECL_IMPORT __attribute__((visibility("default")))
#endif

#if defined(LLI_LIBRARY)
#define LLI_EXPORT LLI_DECL_EXPORT
#else
#define LLI_EXPORT LLI_DECL_IMPORT
#endif