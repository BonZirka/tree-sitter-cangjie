/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// ERRCHECK: %compiler %cmp_opt %f -o %output
class A {
    public var b: ?B = Option<B>.Some(B())
}
class B{
    public var c: Int64 = 100
}

func test() {
    let a: ?A = Option<A>.Some(A())
    a?.b?.c
    a?.b??.c
    return 1
}

main(): Int64 {
    test()
    return 0
}
// ASSERT: scan parse_expected_expression
