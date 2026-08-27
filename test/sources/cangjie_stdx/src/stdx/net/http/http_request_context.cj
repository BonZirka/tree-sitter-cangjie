/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.net.StreamingSocket
import std.sync.Mutex
import stdx.crypto.common.Certificate

public class HttpContext {
    let writerMtx = Mutex()
    // response flushed by user
    var responseFlushedByUser: Bool = false
    // response flushed by user and with chunked
    var responseFlushedWithChunked: Bool = false

    // such as upgraded to websocket
    var upgraded: Bool = false
    var responded: Bool = false

    var _httpConn: ?HttpEngineConn = None

    HttpContext(let _request: HttpRequest, let _responseBuilder: HttpResponseBuilder) {}

    mut prop httpConn: HttpEngineConn {
        get() {
            _httpConn ?? throw HttpException("Internal error, conn in HttpContext is None.")
        }
        set(v) {
            _httpConn = v
        }
    }

    func reset(): Unit {
        responseFlushedByUser = false
        responseFlushedWithChunked = false
        upgraded = false
        responded = false
        _request.reset()
        _responseBuilder.reset()
    }

    public func isClosed(): Bool {
        return httpConn.isClosed()
    }


    public prop request: HttpRequest {
        get() {
            return _request
        }
    }

    public prop responseBuilder: HttpResponseBuilder {
        get() {
            return _responseBuilder
        }
    }

    public prop clientCertificate: ?Array<Certificate> {
        get() {
            match (httpConn.clientCertificate) {
                case Some(c) =>
                    if (c.isEmpty()) {
                        None
                    } else {
                        c
                    }
                case None => None
            }
        }
    }
}

public func upgrade(ctx: HttpContext): StreamingSocket {
    synchronized(ctx.writerMtx) {
        if (ctx.upgraded) {
            throw HttpException("Should not call upgrade more than once.")
        }
        if (ctx.responseFlushedByUser) {
            throw HttpException("Should not upgrade after write response.")
        }
        if (ctx.responded) {
            throw HttpException("Already responded.")
        }
        ctx.httpConn.writeUpgradeResponse(ctx)
        ctx.upgraded = true
    }
    ctx.request._body = HttpEmptyBody.INSTANCE
    return ctx.httpConn.getSocket()
}
