// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-PIPE-1: %run %output 2>&1 | compare %f
// ASSERT: regex initmainAn exception has occurred:[\w\W]Exception: Hello CJC[\w\W]*atexit_12_MultipleExceptions.cj:46[\w\W]*fn3_cjAn exception has occurred:[\w\W]Exception: Exception fn3_cj[\w\W]*atexit_12_MultipleExceptions.cj:29[\w\W]*fn2_cjAn exception has occurred:[\w\W]Exception: Exception fn2_cj[\w\W]*atexit_12_MultipleExceptions.cj:24[\w\W]*fn1_cj

internal import std.process.*
internal import std.fs.*

func printToStderr(str: String) {
    eprint(str, flush: true)
}

func fn1_cj() {
    printToStderr("fn1_cj")
}

func fn2_cj() {
    printToStderr("fn2_cj")
    throw Exception("Exception fn2_cj")
}

func fn3_cj() {
    printToStderr("fn3_cj")
    throw Exception("Exception fn3_cj")
}

var context: Context = Context()

class Context {
    init() {
        printToStderr("init")
        Process.current.atExit(fn1_cj)
        Process.current.atExit(fn2_cj)
        Process.current.atExit(fn3_cj)
    }
}

main() {
    printToStderr("main")
    if (true) {
        throw Exception("Hello CJC")
    }
    return 0
}

public func ASSERT(cond: Bool, errMsg: String) {
}
