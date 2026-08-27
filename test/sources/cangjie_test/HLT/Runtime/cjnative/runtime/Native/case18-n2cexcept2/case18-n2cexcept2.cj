/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: %n.c case18.h
// (not Windows) EXEC: %clang -c %clang_opt %n.c -o lib%n.c.cfile.%cffi_suffix
// (not Windows) EXEC: %compiler -L. -l%n.c.cfile %f %cmp_opt %overflow_wrapping -o %output
// (not Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT:scan C2CJ_Func 11.000000
// ASSERT:scan get from CJ struct: s ->
// ASSERT:scan Exception

class A <: Exception {}

class B <: Exception {}

@C
public func C2CJ_Func(a: Float64): Float64 {
    println("C2CJ_Func " + a.toString())
    var cctest: A = A()
    throw cctest
    return a
}

foreign func C_Func(a: Float64): Float64

main(): Int64 {
    try {
        var bbb: Float64 = unsafe { C_Func(3.0) }
        println(bbb.toString())
        if (bbb == 11.0) {
            return 1
        }
    } catch (b: B) {
        println("Caught UnException")
    } catch (a: A) {
        println(a.toString())
    }
    return 0
}
