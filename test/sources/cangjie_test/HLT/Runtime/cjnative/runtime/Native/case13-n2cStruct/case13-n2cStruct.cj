/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// DEPENDENCE: %n.c case13.h
// (not Windows) EXEC: %clang -c %clang_opt %n.c -o lib%n.c.cfile.%cffi_suffix
// (not Windows) EXEC: %compiler -L. -l%n.c.cfile %f %cmp_opt %overflow_wrapping -o %output
// (not Windows) RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
/* SCAN-IN
11
get from CJ struct: x -> 13 , y -> 14 , z -> 15
 */

@C
public struct BiggerStruct {
    public var x: Int64
    public var y: Int64
    public var z: Int64
    public init(x_: Int64, y_: Int64, z_: Int64) {
        x = x_
        y = y_
        z = z_
    }
}

@C
public func C2CJ_Func(aStruct: BiggerStruct): BiggerStruct {
    println(aStruct.x.toString())
    var xxx: BiggerStruct = BiggerStruct(13, 14, 15)
    return xxx
}

foreign func C_Func(aStruct: BiggerStruct): BiggerStruct

main(): Int64 {
    var aaa: BiggerStruct = BiggerStruct(3, 4, 5)
    var bbb: BiggerStruct = unsafe { C_Func(aaa) }

    if (bbb.x == 13) {
        return 0
    }
    return 1
}
