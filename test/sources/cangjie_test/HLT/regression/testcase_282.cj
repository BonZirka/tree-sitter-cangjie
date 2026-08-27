/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


struct S {
    static let x: Int32 = 100
    var y: () -> Int32 = { => x }
    S(var str!: String = "ok", var y) { }
}

main() {
    let s = S()
    println(s.y())
}
// ASSERT: scan parse_named_parameter_after_unnamed
// ASSERT: scan parse_expected_character


