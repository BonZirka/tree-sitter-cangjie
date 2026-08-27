// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-1: %compiler %noColor %cmp_opt_chir2hlir %f %diag_json -o %output 2>&1 | compare %f
// ASSERT: scan-2 sema_annotation_error_arg_num
// ASSERT: scan sema_annotation_invalid_args_type
// ASSERT: scan sema_only_cfunc_can_use_annotation

@CallingConv
@C
func foo1() {}

@CallingConv[1]
@C
func foo2() {}

@CallingConv[1, 2]
@C
func foo3() {}

@CallingConv[CDECL]
@C
struct Data {}

main() {}
