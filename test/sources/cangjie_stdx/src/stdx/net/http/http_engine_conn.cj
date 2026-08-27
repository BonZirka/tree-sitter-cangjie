/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.net.*
import stdx.crypto.common.Certificate

abstract class HttpEngineConn {
    //add Timeout size limit
    protected var _readTimeout: ?Duration = None
    protected var _writeTimeout: ?Duration = None
    protected var _readHeaderTimeout: ?Duration = None
    protected var _httpKeepAliveTimeout: ?Duration = None
    protected var _maxRequestHeaderSize: ?Int64 = None
    protected var _maxRequestBodySize: ?Int64 = None

    protected mut prop readTimeout: Duration {
        get() {
            _readTimeout ?? throw HttpException("The readTimeout not set yet.")
        }
        set(v) {
            _readTimeout = v
        }
    }

    protected mut prop writeTimeout: Duration {
        get() {
            _writeTimeout ?? throw HttpException("The writeTimeout not set yet.")
        }
        set(v) {
            _writeTimeout = v
        }
    }

    protected mut prop readHeaderTimeout: Duration {
        get() {
            _readHeaderTimeout ?? throw HttpException("The readHeaderTimeout not set yet.")
        }
        set(v) {
            _readHeaderTimeout = v
        }
    }

    protected mut prop maxRequestHeaderSize: Int64 {
        get() {
            _maxRequestHeaderSize ?? throw HttpException("The maxRequestHeaderSize not set yet.")
        }
        set(v) {
            _maxRequestHeaderSize = v
        }
    }

    protected mut prop maxRequestBodySize: Int64 {
        get() {
            _maxRequestBodySize ?? throw HttpException("The maxRequestBodySize not set yet.")
        }
        set(v) {
            _maxRequestBodySize = v
        }
    }

    protected func isClosed(): Bool

    protected prop clientCertificate: ?Array<Certificate>

    protected func getSocket(): StreamingSocket

    protected func writeResponse(ctx: HttpContext): Unit

    protected func writeResponseByWriter(ctx: HttpContext, bodyData: Array<UInt8>): Unit

    protected func writeUpgradeResponse(ctx: HttpContext): Unit
}
