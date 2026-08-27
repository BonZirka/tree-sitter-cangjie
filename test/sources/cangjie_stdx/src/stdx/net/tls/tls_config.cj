/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*
import stdx.net.tls.common.*

/**
 * Whether client need to identify (send certificate).
 */
public enum TlsClientIdentificationMode {
    | Disabled
    | Optional
    | Required
}

extend TlsRawSocket {
    func setRequestedHostName(hostname: String): Unit {
        otherNonIO<Unit> {
            nativeStream, exception => setRequestedHostName(nativeStream, hostname, exception)
        }
    }

    private func setRequestedHostName(
        stream: CPointer<Ssl>,
        name: String,
        exception: CPointer<ExceptionData>
    ): Unit {
        unsafe {
            var result: Int32 = 0
            try (cstring = LibC.mallocCString(name).asResource()) {
                result = CJ_TLS_SetHostName(stream, cstring.value, exception)
            }
            if (result == 0) {
                exception.read().throwException(fallback: "Cannot set hostname on client.")
            }
        }
    }

    func setHostNameForVerify(hostname: String): Unit {
        otherNonIO<Unit> {
            nativeStream, _ => setHostNameForVerify(nativeStream, hostname)
        }
    }

    private func setHostNameForVerify(stream: CPointer<Ssl>, name: String): Unit {
        unsafe {
            var result: Int32 = 0
            try (cstring = LibC.mallocCString(name).asResource()) {
                result = CJ_TLS_SetHostNameForVerify(stream, cstring.value)
            }
            if (result == 0) {
                throw TlsException("Cannot set hostname for verification.")
            }
        }
    }
}
