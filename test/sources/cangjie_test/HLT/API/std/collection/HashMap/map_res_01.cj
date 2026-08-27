/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f  -o %output
// RUN-EXEC: %run %run_opt %output %run_args
import std.collection.*

var r01 = HashMap<Int64, Int64>()
var r02: HashMap<Int64, Int64> = HashMap<Int64, Int64>([])
var r03 = HashMap<Int64, Int64>([(3, 3)]) // <Int64,Int64>
var r04: HashMap<Int64, Int8> = HashMap<Int64, Int8>([(4, 4)]) // <Int64,Int8>

main() {
    return 0
}
