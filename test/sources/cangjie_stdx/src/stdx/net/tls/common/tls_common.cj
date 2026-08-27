/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls.common

import std.collection.Map
import std.deriving.Derive
import std.net.StreamingSocket
import stdx.crypto.common.{Certificate, PrivateKey}

@Derive[ToString, Hashable, Equatable]
public enum TlsVersion {
    V1_2 | V1_3 | TLCP | ...
}

/**
 * Certificate verification mode. A TLS client, once connected, received a server certificate and
 * should verify it to ensure that the connection has been established to the right peer.
 * The default behavior is to use the system trust store. However there are cases when it's required
 * to trust all certificates (in testing and development, usually) or we have a custom CA server whose
 * certificates couldn't be installed into the system trust store for some reason.
 */
public enum CertificateVerifyMode {
    | Default // default verification mode: validate certificates against the system CAs
    | TrustAll // trust all certificates
    | CustomCA(Array<Certificate>) // validate against the provided list of CAs
    | CustomVerify((Array<Certificate>) -> Bool)
}

public interface TlsConfig {
    mut prop verifyMode: CertificateVerifyMode
    mut prop supportedAlpnProtocols: Array<String>
    mut prop supportedVersions: Array<TlsVersion>
    mut prop supportedCipherSuites: Map<TlsVersion, Array<String>> // generalization of old `cipherSuitesV1_x` API
    mut prop certificate: ?(Array<Certificate>, PrivateKey)
}

public interface TlsConnection <: StreamingSocket {
    func handshake(timeout!: ?Duration): TlsHandshakeResult
    prop handshakeResult: ?TlsHandshakeResult
}

public interface TlsHandshakeResult {
    prop version: TlsVersion
    prop cipherSuite: String
    prop peerCertificate: Array<Certificate>
    prop session: ?TlsSession
    prop alpnProtocol: String
    prop serverName: String
}

public interface TlsSession {}
