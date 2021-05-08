cmake_minimum_required(VERSION 3.5)
add_definitions(-DLLI_LIBRARY)

FILE (GLOB header_files *.h)
FILE (GLOB source_files *.c *.cc *.cpp)


add_library(abc_lli SHARED
    ${header_files}
    ${source_files}
)

target_link_libraries(abc_lli 
  PRIVATE
  LLVMCodeGen
  LLVMCore
  LLVMExecutionEngine
  LLVMIRReader
  LLVMInterpreter
  LLVMJITLink
  LLVMMC
  LLVMMCJIT
  LLVMObject
  LLVMOrcShared
  LLVMOrcJIT
  LLVMOrcTargetProcess
  LLVMPasses
  LLVMRuntimeDyld
  LLVMSelectionDAG
  LLVMSupport
  LLVMTarget
  LLVMTransformUtils
  LLVMX86CodeGen
  LLVMX86AsmParser
  LLVMX86Desc
  LLVMX86Disassembler
  LLVMX86Info
  LLVMCoroutines
  LLVMipo
  LLVMAsmParser
  LLVMFrontendOpenMP
  LLVMLinker
  LLVMObjCARCOpts
  LLVMVectorize
  LLVMInstrumentation
  LLVMAsmPrinter
  LLVMDebugInfoDWARF
  LLVMDebugInfoMSF
  LLVMGlobalISel
  LLVMBitWriter
  LLVMScalarOpts
  LLVMAggressiveInstCombine
  LLVMInstCombine
  LLVMAnalysis
  LLVMBitReader
  LLVMTextAPI
  LLVMProfileData
  LLVMCFGuard
  LLVMRemarks
  LLVMBitstreamReader
  LLVMMCParser
  LLVMMCDisassembler
  LLVMBinaryFormat
  LLVMDebugInfoCodeView
  LLVMDemangle)