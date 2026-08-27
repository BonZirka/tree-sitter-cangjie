/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*
import stdx.crypto.common.*
import stdx.net.tls.common.*

type CertificateVerifyCallbackFunction = (Array<Certificate>) -> Bool

extend<T> Option<T> {
    func exists() {
        match (this) {
            case Some(_) => true
            case None => false
        }
    }
    func missing() {
        !exists()
    }
}

extend TlsRawSocket {
    func getPeerCertificate(): ?Array<X509Certificate> {
        otherNonIO<?Array<X509Certificate>> {
            nativeStream, exception => getPeerCertificate(nativeStream, exception)
        }
    }

    private func getPeerCertificate(stream: CPointer<Ssl>, exception: CPointer<ExceptionData>): ?Array<X509Certificate> {
        unsafe {
            var count: UInt32 = 0
            var dynMsg = DynMsg()
            let chain = CJ_TLS_DYN_GetPeerCertificate(stream, inout count, exception, inout dynMsg)
            let resultSize = Int64(count)
            try {
                checkDynMsg(dynMsg)
                if (resultSize != 0 && chain.isNotNull()) {
                    return convertNativeChain(chain, resultSize)
                }
                let exceptionData = exception.read()
                if (exceptionData.hasException) {
                    exception.read().throwException(fallback: "Failed to get client certificates.")
                }
                return None
            } finally {
                CJ_TLS_DYN_Call {
                    dsgMsg: CPointer<DynMsg> => CJ_TLS_DYN_CertChainFree(chain, resultSize, dsgMsg)
                }
            }
        }
    }

    protected static unsafe func convertNativeChain(chain: CPointer<CertChainItem>, itemsCount: Int64): ?Array<X509Certificate> {
        var maxDerSize: Int32 = 0
        var resultCount = 0
        for (index in 0..itemsCount) {
            let item = (chain + index).read()
            if (item.size > 0 && !item.buffer.isNull()) {
                if (item.size > maxDerSize) {
                    maxDerSize = item.size
                }
                resultCount++
            }
        }

        if (resultCount == 0) {
            return None
        }

        let buffer = Array<Byte>(Int64(maxDerSize), repeat: 0)
        let result = ArrayBuilder<X509Certificate>(resultCount)

        for (index in 0..itemsCount) {
            let item = (chain + index).read()
            if (!item.buffer.isNull() && item.size > 0) {
                let cert = convertNativeCertificate(item, buffer)
                result.append(cert)
            }
        }

        return result.toArray()
    }

    private static unsafe func convertNativeCertificate(certificate: CertChainItem, buffer: Array<Byte>): X509Certificate {
        copy(source: CPointer(certificate.buffer), destination: buffer, count: UIntNative(certificate.size))
        X509Certificate.decodeFromDer(DerBlob(buffer[0..Int64(certificate.size)].clone()))
    }
}

@C
struct CertChainItem {
    var buffer: CPointer<Byte> = CPointer()
    var size: Int32 = 0
}

foreign {
    func CJ_TLS_DYN_GetPeerCertificate(
        stream: CPointer<Ssl>,
        countPtr: CPointer<UInt32>,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): CPointer<CertChainItem>

    func CJ_TLS_DYN_CertChainFree(chain: CPointer<CertChainItem>, itemsCount: Int64, dynMsg: CPointer<DynMsg>): Unit
}

func CJ_TLS_DYN_Call<T>(call: (CPointer<DynMsg>) -> T): T {
    unsafe {
        var dynMsg = DynMsg()
        let res = call(inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}
