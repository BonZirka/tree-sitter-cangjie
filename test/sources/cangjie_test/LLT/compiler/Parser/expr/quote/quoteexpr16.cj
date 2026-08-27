// EXEC:%compiler %n.cj -o %output
// EXEC:%run %run_opt %output %run_args

internal import std.ast.*

main(): Int64 {
    quote('\0')
    quote('\n')
    quote('\b')
    quote('\f')
    quote('\r')
    quote('\v' 1 + 2)
    quote("ssss" "Hellow")
    quote("a")
    quote(#"a"#  aa )
    quote("""
a"""   )
    quote(#"
                 a
                 "#  aa )
    quote("""
            a
            """   )
    quote('a')
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
