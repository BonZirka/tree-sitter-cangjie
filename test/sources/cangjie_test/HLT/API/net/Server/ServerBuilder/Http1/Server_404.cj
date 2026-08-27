/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import std.net.*
import std.collection.*
import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit

@Test
public class Test_404 {
    @TestCase
    func serve_404(): Unit {
        let s = ServerBuilder().addr("127.0.0.1").port(0).build()
        spawn {
            s.serve()
        }
        while (s.port == 0) {
            sleep(Duration.millisecond)
        }
        s.distributor.register("/dd", NotFoundHandler())

        let c = ClientBuilder().build()
        let res = c.get("http://127.0.0.1:${s.port}/dd")
        @Expect(res.toString().contains("HTTP/1.1 404 Not Found"), true)
    }
}
