/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt --output-type=staticlib -o %n.%suffix %f

import std.{fs.*, net.*}
import stdx.net.tls.*
import stdx.net.tls.common.*
import stdx.crypto.x509.X509Certificate
import stdx.crypto.common.*

class MyServer {
    private var currentConfig: TlsServerConfig

    init(initialConfig: TlsServerConfig) {
        currentConfig = initialConfig
    }

    /**
     * 更改带有密钥的证书只会影响新的连接
     */
    public mut prop certificate: (Array<X509Certificate>, PrivateKey) {
        get() {
            let (certificates, privateKey) = currentConfig.certificate.getOrThrow()
            (certificates.map({c => (c as X509Certificate).getOrThrow()}), privateKey)
        }
        set(newCertificate) {
            let (certificates, privateKey) = newCertificate
            currentConfig.certificate = (certificates.map({c => c}), privateKey)
        }
    }

    public func onAcceptedConnection(client: StreamingSocket) {
        try (tls = TlsSocket.server(client, serverConfig: currentConfig)) {
            tls.handshake()
        }
    }
}
