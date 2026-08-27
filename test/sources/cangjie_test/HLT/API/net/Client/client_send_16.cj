/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: ../test.cj
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %f -o %output test.cj
// RUN-EXEC: %run_stdx %output %run_args
// ASSERT: scan case pass

import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit
import std.io.*
import std.net.*
import std.runtime.*
import std.argopt.*

main(): Int64 {
    let server = serve()
    let client = ClientBuilder().build()
    var ss = ByteBuffer()
    var req = HttpRequestBuilder()
        .method("PATCH")
        .url("http://127.0.0.1:${server.port}/s")
        .body("foo=bar&foo=bar2&bar=baz")
        .build()
    var a = client.send(req)
    var str = a.toString()
    println(str)
    if (a.status != 200) {
        return 1
    }
    if (str.contains("HTTP/1.1 200 OK") != true) {
        return 2
    }
    if (str.contains("content-length: 5") != true) {
        return 3
    }
    let buf = Array<UInt8>(1024, repeat: 0)
    a.body.read(buf)
    if (!String.fromUtf8(buf).contains("Hello")) {
        return 4
    }
    return 0
}

func serve() {
    let serverSocket = TcpServerSocket(bindAt: 0)
    let server = ServerBuilder().listener(serverSocket).build()
    server.distributor.register("/s", {
        ctx => ctx.responseBuilder.body("Hello")
    })
    spawn {
        server.serve()
    }
    while (server.port == 0) {
        sleep(Duration.millisecond)
    }
    return server
}
