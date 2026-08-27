// EXEC:%frontendCompiler %cmp_opt %dump-parse %f  > %redirectNull

main() {
    var a: Int64 = 1
    var b: Int64 = 2
    var c: Int64 = 3
    ((a, b), c) = ((3, 4), 5)
    return a + b + c - 12
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
