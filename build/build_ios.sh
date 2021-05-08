#! /bin/bash

# compile for OSX (about 2h, 8GB of disk space with BUILD_SHARED_LIBS=ON)
cd ..
mkdir  build_osx
pushd build_osx
cmake ../llvm -DLLVM_BUILD_TEST=OFF -DLLVM_INCLUDE_TESTS=OFF -DLLVM_INCLUDE_GO_TESTS=OFF -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi" ..
cmake --build . -j 4
popd

# get libcxx and libcxxabi out of the way:
#mkdir dontBuild
#mv projects/libcxx dontBuild
#mv projects/libcxxabi dontBuild
# TODO: some combination of build variables might allow us to build these too. 
# Right now, they fail. Maybe CFLAGS with: -D__need_size_t -D_LIBCPP_STRING_H_HAS_CONST_OVERLOADS 

# Now, compile for iOS using the previous build:
# About 24h, 6 GB of disk space
# Flags you could use: LLVM_LINK_LLVM_DYLIB and BUILD_SHARED_LIBS, to make everything use dynamic libraries
# (I did not test these)
mkdir build_ios
pushd build_ios
cmake ../llvm -DLLVM_TARGET_ARCH=AArch64 \
-DLLVM_TARGETS_TO_BUILD=AArch64 \
-DLLVM_DEFAULT_TARGET_TRIPLE=arm64-apple-darwin17.5.0 \
-DLLVM_ENABLE_THREADS=OFF \
-DLLVM_BUILD_TEST=OFF \
-DLLVM_INCLUDE_TESTS=OFF \
-DLLVM_INCLUDE_GO_TESTS=OFF \
-DLLVM_INCLUDE_EXAMPLES=OFF \
-DLLVM_ENABLE_PROJECTS="clang;" \
-DLLVM_TABLEGEN=/Users/joexie/Desktop/llvm/llvm-project/build_osx/bin/llvm-tblgen \
-DCLANG_TABLEGEN=/Users/joexie/Desktop/llvm/llvm-project/build_osx/bin/clang-tblgen \
-DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/ \
-DCMAKE_C_COMPILER=/Users/joexie/Desktop/llvm/llvm-project/build_osx/bin/clang \
-DCMAKE_ASM_COMPILER=/Users/joexie/Desktop/llvm/llvm-project/build_osx/bin/clang \
-DCMAKE_LIBRARY_PATH=/Users/joexie/Desktop/llvm/llvm-project/build_osx/lib/ \
-DCMAKE_INCLUDE_PATH=/Users/joexie/Desktop/llvm/llvm-project/build_osx/include/ \
-DCMAKE_C_FLAGS="-arch arm64 -target arm64-apple-darwin17.5.0 -I/Users/joexie/Desktop/llvm/llvm-project/build_osx/include/ -miphoneos-version-min=11" \
-DCMAKE_CXX_FLAGS="-arch arm64 -target arm64-apple-darwin17.5.0 -I/Users/joexie/Desktop/llvm/llvm-project/build_osx/include/c++/v1/ -miphoneos-version-min=11" \
..
cmake --build . -j 4
popd