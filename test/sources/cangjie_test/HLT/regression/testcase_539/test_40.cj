/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f




func test(): Int64 {
    var a : List<Float64> = [0.0]
    var b : List<Float64> = List<Float64>([Float64(0)].toArray())
    var c : List<Float64> = List<Float64>(Array<Float64(1,0.0))
    return a.size + b.size + c.size - 3
}

main(): Int64 {
    return test()
}
// ASSERT: scan parse_expected_right_delimiter
