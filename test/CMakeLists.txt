project (NoiseJniTest)
add_definitions(-DUNICODE -D_UNICODE)


INCLUDE_DIRECTORIES(. .. ../NoiseJni ../clang/tools/driver ../llvm/tools/lli)

FILE (GLOB header_files *.h)
FILE (GLOB source_files *.c *.cc *.cpp)


add_executable (NoiseJniTest ${header_files} ${source_files})

if (WIN32)
     TARGET_LINK_LIBRARIES (NoiseJniTest  PRIVATE ws2_32 wbemuuid clang lli)
else()
    TARGET_LINK_LIBRARIES (NoiseJniTest  PRIVATE   clang  )
endif()
