#pragma once

#if defined(_MSC_VER) || defined(WIN64) || defined(_WIN64) ||  \
    defined(__WIN64__) || defined(WIN32) || defined(_WIN32) || \
    defined(__WIN32__) || defined(__NT__)
#define CLANG_DECL_EXPORT __declspec(dllexport)
#define CLANG_DECL_IMPORT __declspec(dllimport)
#else
#define CLANG_DECL_EXPORT __attribute__((visibility("default")))
#define CLANG_DECL_IMPORT __attribute__((visibility("default")))
#endif

#if defined(CLANG_LIBRARY)
#define CLANG_EXPORT CLANG_DECL_EXPORT
#else
#define CLANG_EXPORT CLANG_DECL_IMPORT
#endif
