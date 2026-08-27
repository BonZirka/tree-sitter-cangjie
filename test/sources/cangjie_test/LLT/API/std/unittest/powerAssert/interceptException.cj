/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output %cmp_utest_opt
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

import std.unittest.*
import std.unittest.testmacro.*

class Foo <: ToString {
    func getBar() {
        Bar()
    }
    public override func toString() {
        "class Foo"
    }
}

class MyException <: Exception {
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "MyException"
    }
}

class Bar <: ToString {
    prop n: Int64 {
        get() {
            throw MyException("couldn't get `n` field")
        }
    }
    public override func toString() {
        "class Bar"
    }
}

@Test
public class TestA {
    @TestCase
    func case1(): Unit {
        let x = "1"
        @PowerAssert(Foo().getBar().n.toString() == x)
    }
}

/* SCAN-IN
    Assert Failed: `({COLOR=YELLOW}Foo().getBar(){/COLOR}{COLOR=RED}.n{/COLOR}{COLOR=GRAY}.toString() == x{/COLOR})`
                    |_____|        | |          |    |
                   class Foo       | |          |    |
                    |______________| |          |    |
                    |   class Bar    |          |    |
                    |________________|          |    |
                    |  [MyException]            |    |
                    |___________________________|    |
                    |       [not computed]           |
                    |________________________________|
                              [not computed]

    Thrown exception while computing assert expression:
MyException: couldn't get `n` field
 */
