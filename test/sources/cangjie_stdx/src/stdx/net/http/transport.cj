/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.net.*
import std.convert.Parsable

type Connector = (SocketAddress) -> StreamingSocket

let TcpSocketConnector = {
    sa: SocketAddress =>
    let socket = TcpSocket(sa)
    socket.connect()
    return socket
}

struct AddrPort <: ToString & Hashable & Equatable<AddrPort> {
    AddrPort(let addr: String, let port: UInt16) {}

    init(addr: String, portString: String) {
        this.addr = addr
        this.port = try {
            UInt16.parse(portString)
        } catch (e: IllegalArgumentException) {
            throw HttpException("Invalid url address or proxy address.")
        }
    }

    public operator func ==(rhs: AddrPort): Bool {
        return addr == rhs.addr && port == rhs.port
    }
    public operator func !=(rhs: AddrPort): Bool {
        return !(this == rhs)
    }
    public func hashCode(): Int64 {
        var df = DefaultHasher()
        df.write(addr)
        df.write(port)
        df.finish()
    }
    public func toString(): String {
        "${addr}:${port}"
    }
}

struct ConnectMapKey <: ToString & Hashable & Equatable<ConnectMapKey> {
    ConnectMapKey(let addrPort: AddrPort, let httpsProxy: Option<AddrPort>) {}

    public operator func ==(rhs: ConnectMapKey): Bool {
        return httpsProxy == rhs.httpsProxy && addrPort == rhs.addrPort
    }

    public operator func !=(rhs: ConnectMapKey): Bool {
        return !(this == rhs)
    }

    public func hashCode(): Int64 {
        var df = DefaultHasher()
        match (httpsProxy) {
            case Some(v) =>
                df.write(v.addr)
                df.write(v.port)
            case None => ()
        }
        df.write(addrPort.addr)
        df.write(addrPort.port)
        df.finish()
    }

    public func toString(): String {
        let httpsProxyString = match (httpsProxy) {
            case Some(v) => "proxy=${v.addr}:${v.port};"
            case None => ""
        }
        "target=${addrPort.addr}:${addrPort.port};${httpsProxyString}"
    }
}

public struct TransportConfig {
    private var _readTimeout: Duration = Duration.Max
    private var _writeTimeout: Duration = Duration.Max
    private var _readBufferSize: ?Int64 = None
    private var _writeBufferSize: ?Int64 = None
    private var _keepAliveConfig: SocketKeepAliveConfig = SocketKeepAliveConfig()

    public mut prop readTimeout: Duration {
        get() {
            _readTimeout
        }
        set(v) {
            _readTimeout = checkDuration(v)
        }
    }

    public mut prop writeTimeout: Duration {
        get() {
            _writeTimeout
        }
        set(v) {
            _writeTimeout = checkDuration(v)
        }
    }

    public mut prop readBufferSize: ?Int64 {
        get() {
            _readBufferSize
        }
        set(v) {
            _readBufferSize = v
        }
    }

    public mut prop writeBufferSize: ?Int64 {
        get() {
            _writeBufferSize
        }
        set(v) {
            _writeBufferSize = v
        }
    }

    public mut prop keepAliveConfig: SocketKeepAliveConfig {
        get() {
            _keepAliveConfig
        }
        set(v) {
            _keepAliveConfig = v
        }
    }
}
