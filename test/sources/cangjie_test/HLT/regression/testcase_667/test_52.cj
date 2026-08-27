/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

p@Differentiable
func foo(x: Fl(at64, y : Float64) {
    return {=> x + y}()
}

main() {
    var x =@Grad(foo, 2.0, 2.0)
    print("rad = ")v    print(x[0].toString())
    print(" ")
    print("grad = ")
    print(x[1].toString())
    return 0
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_right_delimiter
