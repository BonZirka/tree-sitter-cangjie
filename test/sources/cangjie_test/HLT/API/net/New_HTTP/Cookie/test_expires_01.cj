/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

/*
 * Test description: Test legal and illegal expires
 * Test API: prop expires: ?Time
 */

import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import stdx.net.http.*

@Test
class Test_Cookie_Expires_01 {
    // 合法值：大于1601年
    @TestCase
    func test_expires_01(): Unit {
        var time = DateTime.parse("1601-01-01T00:00:00+00:00")
        var cookie = Cookie("name", "value", expires: time)
        @Expect(cookie.expires == time, true)
    }

    // 默认值
    @TestCase
    func test_expires_02(): Unit {
        var cookie = Cookie("name", "value")
        @Expect(cookie.expires, None)
    }

    // 非法值：小于1601年抛异常
    @TestCase
    func test_expires_03(): Unit {
        var time = DateTime.parse("1600-12-31T23:59:59-08:00")
        try {
            var _ = Cookie("name", "value", expires: time)
            @Expect(1, 2)
        } catch (e: IllegalArgumentException) {
        }
    }
}
