; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare i32 @passthru_i32(i32 returned)
declare i8* @passthru_p8(i8* returned)

define i32 @returned_const_int_arg() {
; CHECK-LABEL: @returned_const_int_arg(
; CHECK-NEXT:    [[X:%.*]] = call i32 @passthru_i32(i32 42)
; CHECK-NEXT:    ret i32 42
;
  %x = call i32 @passthru_i32(i32 42)
  ret i32 %x
}

define i8* @returned_const_ptr_arg() {
; CHECK-LABEL: @returned_const_ptr_arg(
; CHECK-NEXT:    [[X:%.*]] = call i8* @passthru_p8(i8* null)
; CHECK-NEXT:    ret i8* null
;
  %x = call i8* @passthru_p8(i8* null)
  ret i8* %x
}

define i32 @returned_var_arg(i32 %arg) {
; CHECK-LABEL: @returned_var_arg(
; CHECK-NEXT:    [[X:%.*]] = call i32 @passthru_i32(i32 [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[ARG]]
;
  %x = call i32 @passthru_i32(i32 %arg)
  ret i32 %x
}

define i32 @returned_const_int_arg_musttail(i32 %arg) {
; CHECK-LABEL: @returned_const_int_arg_musttail(
; CHECK-NEXT:    [[X:%.*]] = musttail call i32 @passthru_i32(i32 42)
; CHECK-NEXT:    ret i32 [[X]]
;
  %x = musttail call i32 @passthru_i32(i32 42)
  ret i32 %x
}

define i32 @returned_var_arg_musttail(i32 %arg) {
; CHECK-LABEL: @returned_var_arg_musttail(
; CHECK-NEXT:    [[X:%.*]] = musttail call i32 @passthru_i32(i32 [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[X]]
;
  %x = musttail call i32 @passthru_i32(i32 %arg)
  ret i32 %x
}
