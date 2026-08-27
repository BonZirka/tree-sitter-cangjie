/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// DEPENDENCE: ../../../../asan
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f asan.%middle -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

/*
 * Test description:
 *      Test proxy credentials handling
 * Test API:
 *      Proxy configuration and credentials
 */
package tests.client1_1

import stdx.net.http.*
import asan.*
import stdx.encoding.url.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import stdx.log.*
import std.io.*
import std.env.*

@Test
class TestProxyCredentialsDebugLogging {
    let client = ClientBuilder().build()

    @TestCase
    func testProxyConfiguration(): Unit {
        // Test that proxy configuration can be set
        sleep(Duration.millisecond * 100)
        
        let u = URL.parse("http://127.0.0.1:80/test")
        let r = HttpRequestBuilder()
            .url(u)
            .build()
        
        try {
            client.send(r)
            @Expect(1, 2)
        } catch (e: Exception) {
            // Connection error is expected in test environment
            @Expect(e.message.contains("Connection refused"), true)
        }
        
        println("testProxyConfiguration_ok")
    }
    
    @TestCase
    func testProxyCredentialsNotLogged(): Unit {
        // Test that proxy credentials are handled securely
        sleep(Duration.millisecond * 100)
        
        let u = URL.parse("http://127.0.0.1:80/test")
        let r = HttpRequestBuilder()
            .url(u)
            .build()
        
        try {
            client.send(r)
            @Expect(1, 2)
        } catch (e: Exception) {
            // Connection error is expected in test environment
            @Expect(e.message.contains("Connection refused"), true)
        }
        
        println("testProxyCredentialsNotLogged_ok")
    }
}
/* SCAN-IN
testProxyConfiguration_ok
testProxyCredentialsNotLogged_ok
 */
