/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.io.*

public class HttpException <: Exception {
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "HttpException"
    }
}

public class HttpTimeoutException <: Exception {
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "HttpTimeoutException"
    }
}

public class HttpStatusException <: Exception {
    let statusCode: UInt16

    public init(statusCode: UInt16, message: String) {
        super(message)
        this.statusCode = statusCode
    }

    protected override func getClassName(): String {
        return "HttpStatusException"
    }
}

public class WebSocketException <: Exception {
    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "WebSocketException"
    }
}

public class ConnectionException <: IOException {
    public init(message: String) {
        super(message)
    }
    protected func getClassName(): String {
        return "ConnectionException"
    }
}

public class CoroutinePoolRejectException <: Exception {
    public init(message: String) {
        super(message)
    }
    protected func getClassName(): String {
        return "ThreadPoolRejectException"
    }
}

class MethodUnsupportedException <: Exception {
    init(message: String) {
        super(message)
    }
    protected func getClassName(): String {
        return "MethodUnsupportedException"
    }
}

class HpackException <: Exception {
    init(message: String) {
        super(message)
    }
    protected func getClassName(): String {
        return "HpackException"
    }
}

class ConcurrentException <: Exception {
    init(message: String) {
        super(message)
    }
    protected func getClassName(): String {
        return "ConcurrentException"
    }
}

class NegotiateException <: Exception {
    init() {}
    protected func getClassName(): String {
        return "NegotiateException"
    }
}
