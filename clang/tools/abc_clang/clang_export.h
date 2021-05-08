#pragma once
#include "clang_global.h"

#ifdef __cplusplus
extern "C" {
#endif

CLANG_EXPORT int abc_execute(int Argc, const char **Argv);
CLANG_EXPORT void abc_set_error_fd(int fd);
CLANG_EXPORT void abc_set_out_fd(int fd);

#ifdef __cplusplus
}
#endif
