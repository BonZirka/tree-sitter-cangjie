/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args
// ASSERT: scan-not Exception Exception IllegalArgumentException This is an Exception!

main() : Int64 {
    try {
        throw IllegalArgumentException("This is an Exception!")
    } catch (e: OverflowException) {
        println(e.message)
        println("OverflowException is caught!")
    } catch (e: IllegalArgumentException | NegativeArraySizeException) {
        println(e.message)
        println("IllegalArgumentException or NegativeArraySizeException is caught!")
    } finally {
        println("finally is executed!")
    }
    return 0
}
