cd ..
mkdir ios
cd ios
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../ios.toolchain.cmake -DPLATFORM=OS64 -DLLVM_ENABLE_PROJECTS="clang"