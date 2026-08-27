/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt -o %output %f %cmp_utest_opt
// RUN-EXEC: %run %run_opt %output %run_utest_opt %run_args

import std.io.*
import std.fs.*

main() {
    var fileName = "writeTo_06.txt"
    var arr: Array<Byte> = Array<Byte>(10000, {i => UInt8(i % 256)})
    var arr1 = arr.slice(0, 6000).toArray()
    var arr2 = arr.slice(6000, 4000).toArray()
    var file = File.create(fileName)
    @Assert(exists(fileName), true)
    file.close()
    File.writeTo(fileName, arr1)
    File.writeTo(fileName, arr2)
    var readArr = File.readFrom(fileName)
    remove(fileName)
    if (readArr != arr2) {
        return 1
    }
    return 0
}
