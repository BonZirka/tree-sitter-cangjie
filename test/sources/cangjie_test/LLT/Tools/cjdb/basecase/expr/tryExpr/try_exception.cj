// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

main() {
    let arrayTest: Array<Int64> = Array<Int64>(2, repeat: 0)
    var a = try {
        throw ArithmeticException()
    } catch (e: ArithmeticException) {
        println("an arithmeticException happened: " + e.toString())
    } finally {
        println("the finally block is executed")
    }
    0
}