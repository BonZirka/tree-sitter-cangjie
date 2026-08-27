/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



class A <: Exception {
    public init(a: String) {
        super(a)
    }
}

class Ta {
    let ta = Some(B())
    let t = (A("exception_b"), 300)
    let ob = Some(t)
    let f = {i: Int64 => A("exception_c")}
    let oc = Some(f)
    let g = {i: (Int64) -> A => A("exception_d")}
    let od = Some(g)
}

class B {
    public var a: A = A("exception_a")
}

main() {
    var oa = Some(Ta())
    try {
        throw oa?.ta?.a ?? A("exception")
    } catch (e: A) {
        if(e.toString() !=  "Exception: exception_a") {return 1}
    }
    try {
        throw oa?.ob?[0] ?? A("exception")
    } catch (e: A) {
        if(e.toString() !=  "Exception: exception_b") {return 2}
    }
    try {
        throw oa?.oc?(110) ?? A("exception")
    } catch (e: A) {
       if(e.toString() !=  "Exception: exception_c") {return 3}
    }
    try {
        throw oa?.od?{i: Int64 => A("excepti
// ASSERT: scan lex_unterminated_single_line_string


