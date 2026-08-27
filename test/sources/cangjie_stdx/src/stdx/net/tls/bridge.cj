/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import std.collection.concurrent.ConcurrentHashMap

/*
 * It is used to map managed TLS socket objects from different tiers from unmanaged
 * code, mostly openssl callbacks
 */
struct Bridge {
    private static let mapper = ConcurrentHashMap<UIntNative, Bridge>(10000)

    Bridge(
        let socket: TlsSocket,
        private let ssl: CPointer<Ssl>,
        private let context: CPointer<Ctx>,
        let sessionStore: ?SessionStore,
        let keylogCalback: ?KeylogCallbackFunction,
        let certificateVerifyCallback: ?CertificateVerifyCallbackFunction,
        let server: Bool
    ) {
    }

    static func register(bridge: Bridge): Unit {
        mapper.add(bridge.ssl.toUIntNative(), bridge)
        mapper.add(bridge.context.toUIntNative(), bridge)
    }

    static func remove(bridge: Bridge): Unit {
        // the condition is strictly required here otherwise we may remove bridge
        // that is being created right now concurrently
        // because there is a chance that the native memory pointed by ssl and context
        // that is already released (via free) could be already reseved to another SSL and CTX
        // instances for a newly created socket
        // that's why it's important to use the conditional remove
        mapper.remove(bridge.ssl.toUIntNative(), {v => v.socket == bridge.socket})
        mapper.remove(bridge.context.toUIntNative(), {v => v.socket == bridge.socket})
    }

    static func findByStream(ssl: CPointer<Ssl>): ?Bridge {
        mapper.get(ssl.toUIntNative())
    }

    static func findByContext(context: CPointer<Ctx>): ?Bridge {
        mapper.get(context.toUIntNative())
    }
}
