/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *       Test Cookie#init
 * Test API:
 *       init()
 */

package tests.cookie

import stdx.net.http.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

@Test
class TestCookieInit {
    @TestCase
    func cookieInit(): Unit {
        let time1 = DateTime.of(year: 2022, month: 1, dayOfMonth: 1, timeZone: TimeZone.UTC)
        var _ = Cookie("0123456789", "0123456789", path: "/0123456789", domain: "", expires: time1, secure: true,
            httpOnly: true)
        _ = Cookie("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", path: "/ABCDEFGHIJKLMNOPQRSTUVWXYZ/")
        _ = Cookie("abcdefghijklmnopqrstuvwxyz", "\"abcdefghijklmnopqrstuvwxyz\"", path: "abcdefghijklmnopqrstuvwxyz")
        _ = Cookie("!#$%&*+-.^_`|~", "!#$%&*+-.^_`|~'", path: "/!#$%&*+-.^_`|~'/", domain: ".xinhuanet.com")
        _ = Cookie("!#$%&*+-.^_`|~", "()<>@:/[]?={}", path: "/\\()<>@:/[]?={}/", domain: ".xinhuanet.com")
        _ = Cookie("!#$%&*+-.^_`|~", "")
        println("ok")
    }

    @TestCase
    func cookieInitValue(): Unit {
        let _ = Cookie("a", "\"\"")
    }
}

/* SCAN-IN
ok
 */
