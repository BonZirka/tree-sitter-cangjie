/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import std.io.IOStream
import std.sync.*
import stdx.net.tls.common.TlsException

// let ssLInit :AtomicBool = AtomicBool(false)
class TlsContext <: Resource {
    private static var isSslInit = false
    private static let singletonLock: Mutex = Mutex()
    private let sslLock = Mutex()
    private var instance: CPointer<Ctx>
    private var exception: CPointer<ExceptionData> = ExceptionData.create()
    private let server: Bool

    init(existing!: CPointer<Ctx>, server!: Bool) {
        if (existing.isNull()) {
            throw IllegalArgumentException("Existing context shouldn't be null.")
        }
        this.instance = existing
        this.server = server
    }

    init(
        enableKeylog!: Bool = false,
        server!: Bool = false
    ) {
        this(existing: createContext(server, enableKeylog), server: server)
    }

    /**
     * Invokes the block passing SSL_CTX instance to it or fails if already released.
     */
    func withContext<R>(block: (CPointer<Ctx>, CPointer<ExceptionData>) -> R): R {
        synchronized(sslLock) {
            if (instance.isNull()) {
                throw TlsException("SSL context is already released.")
            }

            block(instance, exception)
        }
    }

    /**
     * Creates TlsRawSocket with SSL instance using this context or fails. The returned socket is non-negotiated.
     */
    func createStream(socket: IOStream): TlsRawSocket {
        withContext {
            instance, exception => unsafe {
                let result = CJ_TLS_CreateSsl(instance, if (server) { 1 } else { 0 }, exception)
                if (result.isNull()) {
                    exception.read().throwException(fallback: "TLS failed to create SSL instance.")
                }

                // here the instance is leaking to TlsRawSocket
                // but it's safe because having an instance of SSL* means
                // that it actually holds SSL_CTX* instance as well
                // that's why it's safe to capture this value TOGETHER with SSL*
                return TlsRawSocket(result, instance, socket, server: server)
            }
        }
    }

    public override func isClosed(): Bool {
        synchronized(sslLock) {
            instance.isNull()
        }
    }

    /**
     * Release SSL_CTX instance
     *
     * This doesn't necessarily mean the immediate disposal as OpenSSL may postpone it when still in use.
     */
    public override func close(): Unit {
        synchronized(sslLock) {
            if (instance.isNull()) {
                return
            }

            free(instance)
            ExceptionData.free(exception)
            this.instance = CPointer()
            this.exception = CPointer()
        }
    }

    private static func createContext(server: Bool, enableKeylog: Bool): CPointer<Ctx> {
        ExceptionData.withException {
            exception => unsafe {
                synSslInit()
                let result = CJ_TLS_CreateContext(
                    if (server) { 1 } else { 0 },
                    if (enableKeylog) { keylogCallback } else { CPointer() },
                    exception
                )
                if (result.isNull()) {
                    exception.read().throwException(fallback: "TLS failed to create context.")
                }
                return result
            }
        }
    }

    private static func synSslInit() {
        if (!isSslInit) {
            synchronized(singletonLock) {
                if (!isSslInit) {
                    CJ_TLS_SslInit()
                    isSslInit = true
                }
            }
        }
    }
    private static func free(ctx: CPointer<Ctx>): Unit {
        unsafe {
            if (!ctx.isNull()) {
                CJ_TLS_FreeContext(ctx)
            }
        }
    }
}

foreign {
    func CJ_TLS_DYN_SslInit(dynMsg: CPointer<DynMsg>): Unit

    func CJ_TLS_DYN_CreateContext(
        server: Int32,
        keylogCallback: CFunc<(CPointer<Ssl>, CString) -> Unit>,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): CPointer<Ctx>

    func CJ_TLS_DYN_FreeContext(ssl: CPointer<Ctx>, dynMsg: CPointer<DynMsg>): Unit

    func CJ_TLS_DYN_CreateSsl(ctx: CPointer<Ctx>, server: Int32, exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>): CPointer<Ssl>

    func CJ_TLS_DYN_FreeSsl(ssl: CPointer<Ssl>, dynMsg: CPointer<DynMsg>): Unit
}

func CJ_TLS_SslInit(): Unit {
    unsafe {
        var dynMsg = DynMsg()
        CJ_TLS_DYN_SslInit(inout dynMsg)
        checkDynMsg(dynMsg)
    }
}

func CJ_TLS_CreateContext(
    server: Int32,
    keylogCallback: CFunc<(CPointer<Ssl>, CString) -> Unit>,
    exception: CPointer<ExceptionData>
): CPointer<Ctx> {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_CreateContext(server, keylogCallback, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_FreeContext(ssl: CPointer<Ctx>): Unit {
    unsafe {
        var dynMsg = DynMsg()
        CJ_TLS_DYN_FreeContext(ssl, inout dynMsg)
        checkDynMsg(dynMsg)
    }
}

func CJ_TLS_CreateSsl(ctx: CPointer<Ctx>, server: Int32, exception: CPointer<ExceptionData>): CPointer<Ssl> {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_CreateSsl(ctx, server, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_FreeSsl(ssl: CPointer<Ssl>): Unit {
    unsafe {
        var dynMsg = DynMsg()
        CJ_TLS_DYN_FreeSsl(ssl, inout dynMsg)
        checkDynMsg(dynMsg)
    }
}
