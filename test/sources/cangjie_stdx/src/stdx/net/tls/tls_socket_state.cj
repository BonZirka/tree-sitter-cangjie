/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*
import std.net.StreamingSocket
import stdx.net.tls.common.TlsException

abstract class TlsSocketState <: ToString {
    // this is abstract class instead of interface to fit AtomicReference constraints

    public func close(): Unit // CJ demand it to be public
}

// TLS socket is just created and ready for handshake
class SocketReady <: TlsSocketState {
    SocketReady(
        let socket: StreamingSocket,
        let config: HandshakeConfig
    ) {}

    public func toString(): String {
        return "${socket}, ready for handshake"
    }

    public override func close(): Unit {
        socket.close()
    }
}

// socket is currently in handshake sequence
class SocketInHandshake <: TlsSocketState {
    SocketInHandshake(let socket: StreamingSocket) {}

    public func toString(): String {
        return "${socket}, handshake"
    }

    public override func close(): Unit {
        socket.close()
    }
}

// this states represents TLS socket that is passed handshake and hasn't been closed yet
class SocketConnected <: TlsSocketState {
    private let peerCertificateHolder = Lazy<?Array<X509Certificate>>()

    SocketConnected(
        let stream: TlsRawSocket,
        let socket: StreamingSocket,
        let myCertificate: ?Array<X509Certificate>,
        let isClient: Bool,
        let bridge: Bridge
    ) {
        peerCertificateHolder.configure {
            stream.getPeerCertificate()
        }
    }

    func setPeerCerts(v: ?Array<X509Certificate>): Unit {
        peerCertificateHolder.set(v)
    }

    public func toString(): String {
        return "${stream}, connected"
    }

    /**
     * Does graceful shutdown. Closes the socket first and then waiting for
     * a chance to terminate the native stream.
     * If invoked within a withSession() invocation, then the native resources
     * will be deleted after leaving the invocation.
     */
    public override func close(): Unit {
        try {
            stream.close()
        } finally {
            // if we remove bridge before closing a stream then we may potentially loose
            // sessions that can be negotiated just before the shutdown
            // so it's important to remove it AFTER closing the stream
            Bridge.remove(bridge)
        }
    }

    /**
     * Executes block providing the native pointer with guarantee that it will be
     * never deleted during this invocation.
     *
     * Reentrant and concurrent-safe.
     *
     * Does safely bypass all exceptions inside the block.
     *
     * @throws exception if close() has been invoked before
     */
    func withStream<R>(block: (CPointer<Ssl>) -> R): R {
        stream.otherNonIO<R> {ssl, _ => block(ssl)}
    }

    prop peerCertificate: ?Array<X509Certificate> {
        get() {
            peerCertificateHolder.value
        }
    }

    prop certificate: ?Array<X509Certificate> {
        get() {
            myCertificate
        }
    }
}

// the TLS socket is already closed
class SocketClosed <: TlsSocketState {
    private SocketClosed(let selfClosed: Bool // whether it has been closed but user or by TLS socket itself
        ) {}

    private static let instance: SocketClosed = SocketClosed(false)
    private static let selfClosedInstance: SocketClosed = SocketClosed(true)

    static func getInstance(selfClosed: Bool): SocketClosed {
        match (selfClosed) {
            case true => selfClosedInstance
            case false => instance
        }
    }

    public override func toString(): String {
        "closed"
    }

    static func alreadyClosedException(): Exception {
        TlsException("TLS socket is already closed.")
    }

    static func throwAlreadyClosed(): Nothing {
        throw alreadyClosedException()
    }

    public override func close(): Unit {
    }
}
