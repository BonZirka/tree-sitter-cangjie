/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../../../../asan
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %compile_lib_opt asan/asanGC.cj -o asan.%middle
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %f asan.%middle -o %output %cmp_utest_opt
// RUN-EXEC-PIPE-0: %set_stdx_path %run %run_opt %output %run_utest_opt %run_args 2>&1 

/*
 * Test description:
 * Test API:
 */
package tests.handler

import stdx.net.http.*
import stdx.net.tls
import stdx.crypto.kit
import stdx.log.*
import std.sync.*
import std.time.*
import asan.*

@Test
class TestIllegalData {
    let server = ServerBuilder().addr("0.0.0.0").port(0).build()

    @TestCase
    func uploadNoBoundary(): Unit {
        startServer()
        let client = ClientBuilder().build()
        let req = HttpRequestBuilder()
            .post()
            .url("http://127.0.0.1:${server.port}/upload")
            .header("content-type", "multipart/form-data; boundary=boundary")
            .body("\n".toArray())
            .build()
        let resp = client.send(req)
        println(resp)
        @Assert(resp.status, 400)
        client.close()
        server.close()
    }

    func startServer(): Unit {
        server.distributor.register("/upload", FileHandler("./", handlerType: UpLoad))

        spawn {
            server.serve()
        }
        sleep(Duration.second)
    }
}
