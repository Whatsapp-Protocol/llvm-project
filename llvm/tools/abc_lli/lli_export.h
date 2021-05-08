#pragma once
#include "lli_global.h"

#ifdef __cplusplus
extern "C" {
#endif

LLI_EXPORT int lli_execute(int Argc, const char **Argv);
LLI_EXPORT void lli_set_error_fd(int fd);
LLI_EXPORT void lli_set_out_fd(int fd);

#ifdef __cplusplus
}
#endif