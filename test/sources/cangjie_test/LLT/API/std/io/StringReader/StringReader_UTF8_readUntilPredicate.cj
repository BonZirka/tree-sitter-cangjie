/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %stdx-package -o %n.%suffix %f
// EXEC: %run %run_opt %n.%suffix %run_args | compare %f
// ASSERT: scan ok

/*
 * Test description: Test the func for calss StringReader
 * Test API: public func readUntil(predicate: (Rune)->Bool): Option<String>
 */

internal import std.io.*
internal import std.collection.*

main() {
    var str = "0123456789*abcdefg*ABCDEFG"
    var bas: ByteBuffer = ByteBuffer()
    bas.write(str.toArray())
    var strReader = StringReader(bas)
    var sb: StringBuilder = StringBuilder()
    while (true) {
        var ret = strReader.readUntil({c: Rune => return c == r'*'})
        match (ret) {
            case Some(s) => sb.append(s)
            case None => break
        }
    }
    if (sb.toString() != str) {
        return 1
    }
    println("ok")
    return 0
}
