// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: ./%n.c
// EXEC: %clang %clang_shared_opt %n.c -o %cffi_output
// EXEC: %compiler %cmp_opt %cffi-link %f -o %output
// EXEC: %pwd_to_ld_path %run %output

foreign func C_Abort(): Unit

main(): Int64 {
    var a: (Int64, Unit) = (4, unsafe { C_Abort() })
    return 0
}
