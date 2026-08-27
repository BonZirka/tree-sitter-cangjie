// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix | compare %f
// ASSERT: scan float64inf overflow: inf
// ASSERT: scan float32inf overflow: inf
// ASSERT: scan float16inf overflow: inf

main() {
    let float64inf : Float64 = 2e9023
    println("float64inf overflow: ${float64inf}")
    let float32inf : Float32 = 2e9023
    println("float32inf overflow: ${float32inf}")
    let float16inf : Float16 = 2e9023
    println("float16inf overflow: ${float16inf}")
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
