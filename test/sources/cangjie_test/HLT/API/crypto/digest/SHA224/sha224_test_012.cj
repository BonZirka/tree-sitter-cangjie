/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl -o  %output %f
// RUN-EXEC: %run_stdx %output %run_args 

import stdx.crypto.digest.*
import std.convert.*
import std.crypto.digest.*
import stdx.encoding.hex.*

main() {
    var str: String = "Weclome#MD5$to_Cangjie"
    var sha224Instance = SHA224()
    sha224Instance.write("Weclome#MD5$".toArray())
    sha224Instance.write("to_Cangjie".toArray())
    var sh: Array<Byte> = sha224Instance.finish()
    var result: String = toHexString(sh)
    sha224Instance.reset()
    sha224Instance.reset()

    if (result != "d34cabf1bd25c8cd298a09b1e00785c84bb7b046e8f95fa941d63b32") {
        return 1
    }
    return 0
}
