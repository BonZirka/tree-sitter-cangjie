/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %cmp_opt %link_openssl %stdx-package  %f -o %output  %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args 
/*
 * Test description:
 *      Test WebSocket
 * Test API:
 *      public class WebSocket {}
 */

import stdx.net.http.*
import stdx.net.tls.common.*
import stdx.net.tls
import stdx.crypto.kit
import stdx.encoding.url.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*
import std.collection.*
import stdx.log.*
import stdx.logger.*
import std.console.Console

@Test
class Testwebsocketconf_05 {
    @TestCase
    func test_01(): Unit {
        //write the close frame and continue write the data frame of server.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            websocketServer.write(CloseWebFrame, [3u8, 232u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
            sleep(Duration.millisecond * 100)
            try {
                websocketServer.write(TextWebFrame, Array<UInt8>(4097, repeat: 97))
            } catch (e: WebSocketException) {
                @Expect(e.message.contains("No more data frames can be sent after sending a Close frame"))
            }
            try {
                websocketServer.write(BinaryWebFrame, Array<UInt8>(4097, repeat: 97))
            } catch (e: WebSocketException) {
                @Expect(e.message.contains("No more data frames can be sent after sending a Close frame"))
            }
            websocketServer.closeConn()
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        let websocketFrame1 = websocket.read()
        @Expect(websocketFrame1.fin, true)
        @Expect(websocketFrame1.frameType, CloseWebFrame)
        @Expect(websocketFrame1.payload[..2], [3u8, 232u8])
        @Expect(String.fromUtf8(websocketFrame1.payload[2..]), "normal\"")
        sleep(Duration.millisecond * 200)
        websocket.closeConn()
        client.close()
        server.close()
    }

    @TestCase
    func test_02(): Unit {
        //write the close frame of the server and then write the control frame.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            websocketServer.write(CloseWebFrame, [3u8, 232u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
            sleep(Duration.millisecond * 100)
            websocketServer.write(PingWebFrame, [3u8, 232u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
            sleep(Duration.millisecond * 100)
            websocketServer.write(PongWebFrame, [3u8, 233u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
            websocketServer.closeConn()
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        let websocketFrame1 = websocket.read()
        @Expect(websocketFrame1.fin, true)
        @Expect(websocketFrame1.frameType, CloseWebFrame)
        @Expect(websocketFrame1.payload[..2], [3u8, 232u8])
        @Expect(String.fromUtf8(websocketFrame1.payload[2..]), "normal\"")
        sleep(Duration.millisecond * 100)
        let websocketFrame2 = websocket.read()
        @Expect(websocketFrame2.fin, true)
        @Expect(websocketFrame2.frameType, PingWebFrame)
        @Expect(websocketFrame2.payload[0..], [3u8, 232u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
        sleep(Duration.millisecond * 100)
        let websocketFrame3 = websocket.read()
        @Expect(websocketFrame3.fin, true)
        @Expect(websocketFrame3.frameType, PongWebFrame)
        @Expect(websocketFrame3.payload[0..], [3u8, 233u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
        sleep(Duration.millisecond * 100)
        websocket.closeConn()
        client.close()
        server.close()
    }

    @TestCase
    func test_03(): Unit {
        //the server write the data after closeConn the client.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            sleep(Duration.millisecond * 100)
            try {
                websocketServer.read()
                @Expect(1, 2)
            } catch (e: SocketException) {
                @Expect(e.message.contains("Broken pipe"))
            }
            websocketServer.closeConn()
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        websocket.closeConn()
        sleep(Duration.millisecond * 400)
        client.close()
        server.close()
    }

    @TestCase
    func test_04(): Unit {
        //the client write the data after closeConn the client.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            websocketServer.closeConn()
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        websocket.closeConn()
        try {
            websocket.write(CloseWebFrame, [3u8, 233u8, 110u8, 111u8, 114u8, 109u8, 97u8, 108u8, 34u8])
            @Expect(1, 2)
        } catch (e: WebSocketException) {
            @Expect(e.message.contains("The connection is closed"))
        }
        client.close()
        server.close()
    }

    @TestCase
    func test_05(): Unit {
        //the client write the data after closeConn the server.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            websocketServer.closeConn()
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        sleep(Duration.millisecond * 100)
        try {
            websocket.read()
            @Expect(1, 2)
        } catch (e: ConnectionException) {
            @Expect(e.message.contains("Socket is closed"))
        }
        websocket.closeConn()
        client.close()
        server.close()
    }

    @TestCase
    func test_06(): Unit {
        //the server write the data after closeConn the server.
        let server = ServerBuilder().addr("127.0.0.1").port(0).build()
        func handler1(ctx: HttpContext): Unit {
            let websocketServer = WebSocket.upgradeFromServer(
                ctx,
                userFunc: {
                    request: HttpRequest =>
                    let value = request.headers.getFirst("test") ?? ""
                    @Expect(value, "zpstest")
                    let headers = HttpHeaders()
                    headers.add("resp", value)
                    headers
                }
            )
            websocketServer.closeConn()
            try {
                websocketServer.write(TextWebFrame, Array<UInt8>(4097, repeat: 97))
                @Expect(1, 2)
            } catch (e: WebSocketException) {
            }
        }
        func startServer() {
            server.logger.level = LogLevel.DEBUG
            server.distributor.register("/webSocket", handler1)
            server.serve()
        }
        spawn {startServer()}
        while (server.port == 0) {
            sleep(Duration.millisecond)
        }

        let client = ClientBuilder().build()
        client.logger.level = LogLevel.DEBUG
        let u = URL.parse("ws://127.0.0.1:${server.port}/webSocket")
        let headers = HttpHeaders()
        headers.add("test", "zpstest")
        let websocket: WebSocket
        let respHeaders: HttpHeaders
        (websocket, respHeaders) = WebSocket.upgradeFromClient(client, u, headers: headers)
        let value1 = respHeaders.getFirst("resp") ?? ""
        @Expect(value1, "zpstest")
        sleep(Duration.millisecond * 400)
        websocket.closeConn()
        client.close()
        server.close()
    }
}
