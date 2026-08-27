// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE: %compiler %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args

public open class CA {
    public mut open prop abc: Int64 {
        get() {
            1
        }
        set(v) {}
    }
}

func test1() {
    var a = CA()
    for (i in 0..10) {
        a.abc += 1
    }
}

func test2() {
    var a = CA()
    for (i in 0..10) {
        a.abc -= 1
    }
}

func test3() {
    var a = CA()
    for (i in 0..10) {
        a.abc *= 1
    }
}

func test4() {
    var a = CA()
    for (i in 0..10) {
        a.abc /= 1
    }
}

main() {
    test1()
    test2()
    test3()
    test4()
    0
}
