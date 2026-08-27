/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

func f(x: Int32): Float64 {
    Float64(x)
}

func g(x: Float32): Int32 {
    Int32(x)
}

var fg = f ~> g

main() {
    return 1
}
// ASSERT: scan sema_invalid_binary_expr
