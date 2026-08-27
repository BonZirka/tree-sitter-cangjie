/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl -o %output  %f
// RUN-EXEC: %run_stdx %output %run_args  

import stdx.crypto.keys.*
import stdx.crypto.digest.*
import std.io.*
import std.crypto.digest.*

main() {
    var rsaPri = RSAPrivateKey(2048)
    var rsaPub = RSAPublicKey(rsaPri)

    var str: String = "cangjie-helloworld"
    var sha256Instance = SHA256()
    var sh: Array<Byte> = digest(sha256Instance, str)

    var sig = rsaPri.sign(sha256Instance, sh, padType: PSS(PSSOption(Int32(2048 / 8 - sh.size - 2))))
    if (rsaPub.verify(sha256Instance, sh, sig, padType: PSS(PSSOption(Int32(2048 / 8 - sh.size - 2))))) {
        return 0
    } else {
        return 1
    }
}
