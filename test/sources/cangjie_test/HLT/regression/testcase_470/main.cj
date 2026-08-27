/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 

import std.io.*
import std.time.*
import std.convert.*
import stdx.net.http.*
import std.net.*
import stdx.log.*
import stdx.logger.*
import std.console.Console
import std.fs.*
import stdx.net.tls.*
import stdx.net.tls.common.*
import stdx.crypto.x509.X509Certificate
import stdx.crypto.keys.GeneralPrivateKey
import stdx.crypto.common.*

var server: Server = unsafe { zeroValue<Server>() }

let reps: UInt16 = 11840

func serverConfig(): TlsServerConfig {
    let pem0 = String.fromUtf8(readToEnd(File("data/end_rsa.cer", Read)))
    let pem02 = String.fromUtf8(readToEnd(File("data/end_rsa_private_key.pem", Read)))
    var tlsConfig = TlsServerConfig(X509Certificate.decodeFromPem(pem0), GeneralPrivateKey.decodeFromPem(pem02))
    tlsConfig.supportedAlpnProtocols = ["http/1.1"]
    tlsConfig
}

func clientConfig(): TlsClientConfig {
    var tlsConfig = TlsClientConfig()
    let pem = String.fromUtf8(readToEnd(File("data/root_rsa.cer", Read)))
    tlsConfig.verifyMode = CustomCA(X509Certificate.decodeFromPem(pem).map({c => c}))
    tlsConfig.supportedAlpnProtocols = ["http/1.1"]
    tlsConfig
}

func benchmarkDeleteHttps(): Duration {
    spawn {
        serve()
    }
    sleep(Duration.second)
    let port = server.port
    let cfg = clientConfig()
    let client = ClientBuilder().tlsConfig(cfg).build()
    var startTime = DateTime.now()
    for (_ in 0..reps) {
        client.delete("https://127.0.0.1:${port}/dd")
    }
    var endTime = DateTime.now()
    return endTime - startTime
}

func timeBenchmarkDeleteHttps() {
    var perTime = Float64((benchmarkDeleteHttps()).toNanoseconds()) / Float64(reps)
    println("BenchmarkDeleteHttps: ${perTime.format(".2")} ns/op")
}

func serve() {
    let socket = TcpServerSocket(bindAt: IPSocketAddress("0.0.0.0", 0))
    let server_cfg = serverConfig()
    server = ServerBuilder().listener(socket).tlsConfig(server_cfg).build()
    server.distributor.register("/dd", {
            ctx =>
            ctx.responseBuilder.body(Array<UInt8>())
            return
        })
    server.logger.level = LogLevel.OFF
    server.serve()
}

main(): Int64 {
    timeBenchmarkDeleteHttps()
    return 0
}


