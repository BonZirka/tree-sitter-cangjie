// EXEC:%compiler %n.cj -o %output
// EXEC:%run %run_opt %output %run_args
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: 2
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: r'2'
// ASSERT: regex-auto description: integer_literal, token_id: 139, token_literal_value: true

internal import std.ast.*

func call1():Int8 {
    2
}

func call2():Int16 {
    2
}

func call3():Int32 {
    2
}

func call4():Int64 {
    2
}

func call5():UInt8 {
    2
}

func call6():UInt16 {
    2
}

func call7():UInt32 {
    2
}

func call8():UInt64 {
    2
}

func call9():Float16 {
    2.0
}

func call10():Float32 {
    2.0
}

func call11():Float64 {
    2.0
}


func call14():Rune {
    r'2'
}

func call15():Bool {
    true
}

main(): Int64 {
    let a = quote($(call1()))
    let b = quote($(call2()))
    let c = quote($(call3()))
    let d = quote($(call4()))
    let e = quote($(call5()))
    let f = quote($(call6()))
    let g = quote($(call7()))
    let h = quote($(call8()))
    let i = quote($(call9()))
    let j = quote($(call10()))
    let k = quote($(call11()))

    let n = quote($(call14()))
    let o = quote($(call15()))

    let s = quote($("aaaaa"))
    let s1 = quote($(r'b'))
    let s2 = quote($("""
ccccc"""))
    let s3 = quote($(#"ddddd"#))

    let ss = quote($(true))
    let ss1 = quote($(false))
    let ss2 = quote($(1))
    let ss3 = quote($(1.1))
    let ss4 = quote($(1.11))

    a.dump()
    b.dump()
    c.dump()
    d.dump()
    e.dump()
    f.dump()
    g.dump()
    h.dump()
    i.dump()
    j.dump()
    k.dump()
    n.dump()
    o.dump()
    0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
