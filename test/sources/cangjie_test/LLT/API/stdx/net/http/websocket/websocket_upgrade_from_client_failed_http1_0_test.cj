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
 *      Test WebSocket#upgradeFromClient
 * Test API:
 *      public static func upgradeFromClient(client: Client, url: URL,
                                        subProtocols!: ArrayList<String> = ArrayList<String>(),
                                        headers!: HttpHeaders = HttpHeaders()): (WebSocket, HttpHeaders)
 */
package tests.websocket

import stdx.net.http.*
import stdx.crypto.kit
import stdx.encoding.url.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import std.collection.*
import stdx.log.*
import stdx.encoding.base64.*

@Test
class TestWebSocketUpgradeFromClientFailedHttp10 {
    let serverSocket = TcpServerSocket(bindAt: 0)

    @TestCase
    func webSocketUpgradeFromClientFailedHttp10(): Unit {
        spawn {serverPacketCapture()}
        sleep(Duration.millisecond * 100)
        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let port = (serverSocket.localAddress as IPSocketAddress)?.port ?? 0
        let u = URL.parse("ws://127.0.0.1:${port}/a")
        for (_ in 0..10) {
            try {
                WebSocket.upgradeFromClient(client, u)
            } catch (e: Exception) {
                @Expect(e.message, "Upgrade to websocket failed, wrong http version HTTP/1.0 which cannot be upgraded to websocket.")
            }
        }
        let resp = client.get("http://127.0.0.1:${port}/a")
        println(resp)
        client.close()
        serverSocket.close()
        println("websocket_upgrade_from_client_failed_10_test_ok")
    }

    func serverPacketCapture() {
        serverSocket.bind()
        let buf = Array<UInt8>(4096, repeat: 0)
        for (_ in 0..10) {
            let server = serverSocket.accept()
            server.read(buf)
            server.write("HTTP/1.0 200 ok\r\n\r\n".toArray())
            server.close()
        }
        let server = serverSocket.accept()
        server.read(buf)
        server.write("HTTP/1.0 204 ok\r\nconnection: close\r\n\r\n".toArray())
        server.close()
    }
}

/* SCAN-IN
websocket_upgrade_from_client_failed_10_test_ok
 */
