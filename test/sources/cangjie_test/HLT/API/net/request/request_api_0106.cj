/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output
// RUN-EXEC: %run_stdx %output %run_args

import stdx.net.http.*
import std.io.*

main(): Int64 {
    var req = HttpRequestBuilder().method("PATCH").url("http://www.examplenet.com").build()
    if (req.method != "PATCH") {
        return 1
    }
    if (req.remoteAddr != "") {
        return 2
    }

    if (!req.toString().contains("PATCH  HTTP/1.1")) {
        return 3
    }

    if (req.url.toString() != "http://www.examplenet.com") {
        return 4
    }
    return 0
}
