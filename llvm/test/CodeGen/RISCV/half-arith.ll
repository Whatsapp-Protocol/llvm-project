; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFH %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFH %s

; These tests are each targeted at a particular RISC-V FPU instruction. Most
; other files in this folder exercise LLVM IR instructions that don't directly
; match a RISC-V instruction.

define half @fadd_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fadd_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fadd.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fadd_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fadd.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fadd half %a, %b
  ret half %1
}

define half @fsub_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fsub_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fsub.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fsub_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fsub.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fsub half %a, %b
  ret half %1
}

define half @fmul_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fmul_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmul.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fmul_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmul.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fmul half %a, %b
  ret half %1
}

define half @fdiv_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fdiv_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fdiv.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fdiv_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fdiv.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fdiv half %a, %b
  ret half %1
}

declare half @llvm.sqrt.f16(half)

define half @fsqrt_s(half %a) nounwind {
; RV32IZFH-LABEL: fsqrt_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fsqrt.h fa0, fa0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fsqrt_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fsqrt.h fa0, fa0
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.sqrt.f16(half %a)
  ret half %1
}

declare half @llvm.copysign.f16(half, half)

define half @fsgnj_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fsgnj_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fsgnj.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fsgnj_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fsgnj.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.copysign.f16(half %a, half %b)
  ret half %1
}

; This function performs extra work to ensure that
; DAGCombiner::visitBITCAST doesn't replace the fneg with an xor.
define i32 @fneg_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fneg_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fadd.h ft0, fa0, fa0
; RV32IZFH-NEXT:    fneg.h ft1, ft0
; RV32IZFH-NEXT:    feq.h a0, ft0, ft1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fneg_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fadd.h ft0, fa0, fa0
; RV64IZFH-NEXT:    fneg.h ft1, ft0
; RV64IZFH-NEXT:    feq.h a0, ft0, ft1
; RV64IZFH-NEXT:    ret
  %1 = fadd half %a, %a
  %2 = fneg half %1
  %3 = fcmp oeq half %1, %2
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; This function performs extra work to ensure that
; DAGCombiner::visitBITCAST doesn't replace the fneg with an xor.
define half @fsgnjn_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fsgnjn_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fadd.h ft0, fa0, fa1
; RV32IZFH-NEXT:    fsgnjn.h fa0, fa0, ft0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fsgnjn_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fadd.h ft0, fa0, fa1
; RV64IZFH-NEXT:    fsgnjn.h fa0, fa0, ft0
; RV64IZFH-NEXT:    ret
  %1 = fadd half %a, %b
  %2 = fneg half %1
  %3 = call half @llvm.copysign.f16(half %a, half %2)
  ret half %3
}

declare half @llvm.fabs.f16(half)

; This function performs extra work to ensure that
; DAGCombiner::visitBITCAST doesn't replace the fabs with an and.
define half @fabs_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fabs_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fadd.h ft0, fa0, fa1
; RV32IZFH-NEXT:    fabs.h ft1, ft0
; RV32IZFH-NEXT:    fadd.h fa0, ft1, ft0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fabs_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fadd.h ft0, fa0, fa1
; RV64IZFH-NEXT:    fabs.h ft1, ft0
; RV64IZFH-NEXT:    fadd.h fa0, ft1, ft0
; RV64IZFH-NEXT:    ret
  %1 = fadd half %a, %b
  %2 = call half @llvm.fabs.f16(half %1)
  %3 = fadd half %2, %1
  ret half %3
}

declare half @llvm.minnum.f16(half, half)

define half @fmin_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fmin_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmin.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fmin_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmin.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.minnum.f16(half %a, half %b)
  ret half %1
}

declare half @llvm.maxnum.f16(half, half)

define half @fmax_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fmax_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmax.h fa0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fmax_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmax.h fa0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.maxnum.f16(half %a, half %b)
  ret half %1
}

define i32 @feq_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: feq_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    feq.h a0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: feq_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    feq.h a0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fcmp oeq half %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @flt_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: flt_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    flt.h a0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: flt_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    flt.h a0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fcmp olt half %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fle_s(half %a, half %b) nounwind {
; RV32IZFH-LABEL: fle_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fle.h a0, fa0, fa1
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fle_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fle.h a0, fa0, fa1
; RV64IZFH-NEXT:    ret
  %1 = fcmp ole half %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

declare half @llvm.fma.f16(half, half, half)

define half @fmadd_s(half %a, half %b, half %c) nounwind {
; RV32IZFH-LABEL: fmadd_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmadd.h fa0, fa0, fa1, fa2
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fmadd_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmadd.h fa0, fa0, fa1, fa2
; RV64IZFH-NEXT:    ret
  %1 = call half @llvm.fma.f16(half %a, half %b, half %c)
  ret half %1
}

define half @fmsub_s(half %a, half %b, half %c) nounwind {
; RV32IZFH-LABEL: fmsub_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x ft0, zero
; RV32IZFH-NEXT:    fadd.h ft0, fa2, ft0
; RV32IZFH-NEXT:    fmsub.h fa0, fa0, fa1, ft0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fmsub_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x ft0, zero
; RV64IZFH-NEXT:    fadd.h ft0, fa2, ft0
; RV64IZFH-NEXT:    fmsub.h fa0, fa0, fa1, ft0
; RV64IZFH-NEXT:    ret
  %c_ = fadd half 0.0, %c ; avoid negation using xor
  %negc = fsub half -0.0, %c_
  %1 = call half @llvm.fma.f16(half %a, half %b, half %negc)
  ret half %1
}

define half @fnmadd_s(half %a, half %b, half %c) nounwind {
; RV32IZFH-LABEL: fnmadd_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x ft0, zero
; RV32IZFH-NEXT:    fadd.h ft1, fa0, ft0
; RV32IZFH-NEXT:    fadd.h ft0, fa2, ft0
; RV32IZFH-NEXT:    fnmadd.h fa0, ft1, fa1, ft0
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fnmadd_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x ft0, zero
; RV64IZFH-NEXT:    fadd.h ft1, fa0, ft0
; RV64IZFH-NEXT:    fadd.h ft0, fa2, ft0
; RV64IZFH-NEXT:    fnmadd.h fa0, ft1, fa1, ft0
; RV64IZFH-NEXT:    ret
  %a_ = fadd half 0.0, %a
  %c_ = fadd half 0.0, %c
  %nega = fsub half -0.0, %a_
  %negc = fsub half -0.0, %c_
  %1 = call half @llvm.fma.f16(half %nega, half %b, half %negc)
  ret half %1
}

define half @fnmsub_s(half %a, half %b, half %c) nounwind {
; RV32IZFH-LABEL: fnmsub_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x ft0, zero
; RV32IZFH-NEXT:    fadd.h ft0, fa0, ft0
; RV32IZFH-NEXT:    fnmsub.h fa0, ft0, fa1, fa2
; RV32IZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fnmsub_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x ft0, zero
; RV64IZFH-NEXT:    fadd.h ft0, fa0, ft0
; RV64IZFH-NEXT:    fnmsub.h fa0, ft0, fa1, fa2
; RV64IZFH-NEXT:    ret
  %a_ = fadd half 0.0, %a
  %nega = fsub half -0.0, %a_
  %1 = call half @llvm.fma.f16(half %nega, half %b, half %c)
  ret half %1
}