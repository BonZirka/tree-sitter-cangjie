/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// (CJNATIVE) EXEC: %compiler %cmp_opt %f %cmp_utest_opt -o %output
// (CJNATIVE) EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT:regex-begin .*PASSED.*: 1,.*SKIPPED.*: 0,.*ERROR.*: 0
// ASSERT:regex-next .*FAILED.*: 0

import std.time.*
import std.sync.*
import std.net.*
import std.unittest.*
import std.unittest.testmacro.*

/**
 * 测试头说明
 * line 1 EXEC: %compiler %cmp_opt %f --test -o %output
 * 编译指令，增加--test选项
 * line 2 EXEC-PIPE-NUM: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f
 * 执行测试用例并比较结果，test的返回值是 失败用例数量 + 错误用例数量
 * line 3-4 ASSERT:regex-begin
 * 对测试结果进行比较，通过个数，跳过，错误和失败
 *
 * 测试用例说明
 * 测试接口：
 * public class TcpSocket <: StreamingSocket
 *     public override func read(buffer: Array<Byte>): Int64
 *     public func close(): Unit
 *
 * 功能分析：
 * 1. 构造并发调用 read 和 close 的场景，检查结果是否符合预期
 */
var SERVER_PORT: UInt16 = 0
let arrsize = 100

func runTcpServer() {
    try (serverSocket = TcpServerSocket(bindAt: 0)) {
        serverSocket.bind()
        SERVER_PORT = (serverSocket.localAddress as IPSocketAddress)?.port ?? 0
        try (server = serverSocket.accept()) {
            let buf = Array<Byte>(arrsize, repeat: 0)
            let flag = AtomicBool(false)
            spawn {
                =>
                var all = 0
                try {
                    flag.store(true)
                    while (all < arrsize * 1000) {
                        let count = server.read(buf)
                        all += count
                        if (count == 0) {
                            break
                        }
                    }
                } catch (e: SocketException) {}
            }
            spawn {
                => if (flag.load() == true) {
                    server.close()
                }
            }
        }
    } catch (e: SocketException) {}
}

@Test
public class Test_TcpSocket {
    @TestCase
    func case_tcp(): Unit {
        for (_ in 0..1) {
            let s1 = spawn {
                runTcpServer()
            }
            sleep(Duration.millisecond * 500)

            try (socket = TcpSocket("127.0.0.1", SERVER_PORT)) {
                socket.connect()
                for (_ in 0..1000) {
                    let buf = Array<Byte>(arrsize, repeat: 1)
                    socket.write(buf)
                }
            } catch (e: SocketException) {}
            s1.get()
            @Expect(1, 1)
        }
    }
}
