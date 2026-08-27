/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

interface WebSocketConn {
    func readRaw(byteArray: Array<UInt8>): Int64
    func writeRaw(byteArray: Array<UInt8>): Unit
    func close(): Unit
}

class WebSocketConn1 <: WebSocketConn {
    WebSocketConn1(let conn: BufferedConn) {}
    public func readRaw(byteArray: Array<UInt8>): Int64 {
        conn.readFull(byteArray)
    }

    public func writeRaw(byteArray: Array<UInt8>): Unit {
        conn.write(byteArray)
    }

    public func close(): Unit {
        conn.close()
    }
}
