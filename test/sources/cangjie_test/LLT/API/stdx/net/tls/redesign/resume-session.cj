/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ../files
// EXEC: %compiler %import-cangjie-stdx  %cmp_opt %cmp_utest_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_utest_opt %run_args
// ASSERT: scan server key
// ASSERT: scan client key

import stdx.net.tls.*
import stdx.net.tls.common.*
import stdx.crypto.x509.X509Certificate
import stdx.crypto.keys.*
import stdx.crypto.common.*
import stdx.net.tls.common.*
import std.{net.*, fs.*, io.*}
import std.unittest.*
import std.unittest.testmacro.*

// shared session context storing sessions
let sessionContext = TlsServerSession.fromName("abc")

@Test
class TestResumeSession {
    @TestCase[version in [ TlsVersion.V1_2 ]]
    func test(version: TlsVersion): Unit {
        let (tcpServer, port) = runTcpServer()
        let f = spawn {
            let server1 = runTlsServer(tcpServer, version)
            println("accepted the first")
            sleep(Duration.second)
            server1.socket.close()
            server1.close()
            sleep(Duration.second)
            let server2 = runTlsServer(tcpServer, version)
            println("accepted the second")
            server2.close()
        }
        let session = runTlsClient(port, version)
        println("connected 1: ${session}")
        println("======================================")

        let session2 = runTlsClient(port, version, session: session)
        println("connected 2: ${session2}")
        f.get()
        tcpServer.close()

        @Expect(session == session2)
    }
}

func runTcpServer(): (TcpServerSocket, UInt16) {
    let server = TcpServerSocket(bindAt: IPSocketAddress("127.0.0.1", 0))
    server.bind()
    let port = (server.localAddress as IPSocketAddress)?.port ?? 0

    return (server, port)
}

func runTlsServer(server: TcpServerSocket, version: TlsVersion): TlsSocket {
    var serverConf = serverConfig()
    serverConf.supportedAlpnProtocols = ["http/1.1"]
    serverConf.supportedVersions = [version]
    let socket = server.accept()
    let tlsServer = TlsSocket.server(socket, serverConfig: serverConf, session: sessionContext)
    tlsServer.handshake()
    return tlsServer
}

func runTlsClient(port: UInt16, version: TlsVersion, session!: ?TlsClientSession = None): ?TlsClientSession {
    var clientCfg = clientConfig()
    var session_: ?TlsClientSession = None

    clientCfg.supportedAlpnProtocols = ["http/1.1"]
    clientCfg.supportedVersions = [version]
    try (clientTcp = TcpSocket("127.0.0.1", port)) {
        clientTcp.connect()
        try (client = TlsSocket.client(clientTcp, clientConfig: clientCfg, session: session)) {
            client.handshake()
            client.read([1, 2, 3])
            session_ = match (client.handshakeResult.getOrThrow().session) {
                case Some(s) => (s as TlsClientSession).getOrThrow()
                case None => None
            }
        }
    }

    return session_
}

func serverConfig(): TlsServerConfig {
    let pem = String.fromUtf8(readToEnd(File("./files/root_ecdsa.cer", Read)))
    let pem0 = String.fromUtf8(readToEnd(File("./files/end_ecdsa.cer", Read)))
    let pem02 = String.fromUtf8(readToEnd(File("./files/end_ecdsa_private_key.pem", Read)))
    var tlsConfig = TlsServerConfig(X509Certificate.decodeFromPem(pem0), GeneralPrivateKey.decodeFromPem(pem02))
    tlsConfig.supportedAlpnProtocols = ["h2"]
    tlsConfig.clientIdentityRequired = Required
    tlsConfig.verifyMode = CustomCA(X509Certificate.decodeFromPem(pem).map({c => c}))
    tlsConfig.keylogCallback = {
        _, line => println("server key: ${line}")
    }
    tlsConfig
}

func clientConfig(): TlsClientConfig {
    var tlsConfig = TlsClientConfig()
    tlsConfig.keylogCallback = {
        _, line => println("client key: ${line}")
    }
    let pem = String.fromUtf8(readToEnd(File("./files/root_ecdsa.cer", Read)))
    tlsConfig.verifyMode = CustomCA(X509Certificate.decodeFromPem(pem).map({c => c}))
    let pem0 = String.fromUtf8(readToEnd(File("./files/end_ecdsa.cer", Read)))
    let pem02 = String.fromUtf8(readToEnd(File("./files/end_ecdsa_private_key.pem", Read)))

    tlsConfig.certificate = (X509Certificate.decodeFromPem(pem0).map({c => c}), GeneralPrivateKey.decodeFromPem(pem02))
    tlsConfig.supportedAlpnProtocols = ["h2"]
    tlsConfig
}
