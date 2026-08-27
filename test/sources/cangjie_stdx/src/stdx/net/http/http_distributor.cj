/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.collection.HashMap

public interface HttpRequestDistributor {
    func register(path: String, handler: HttpRequestHandler): Unit

    func register(path: String, handler: (HttpContext) -> Unit): Unit {
        register(path, FuncHandler(handler))
    }

    func distribute(path: String): HttpRequestHandler
}

class DirectDistributor <: HttpRequestDistributor {
    let map = HashMap<String, HttpRequestHandler>()

    public func register(path: String, handler: HttpRequestHandler): Unit {
        if (path == ASTERISK) {
            throw HttpException("Invalid path.")
        }
        let register = canonicalPath(path)
        if (map.contains(register)) {
            throw HttpException("Path: ${register} already registered.")
        }
        map.add(register, handler)
    }

    public func distribute(path: String): HttpRequestHandler {
        let distribute = canonicalPath(path)
        return match (map.get(distribute)) {
            case Some(handler) => handler
            case None => NotFoundHandler()
        }
    }
}
