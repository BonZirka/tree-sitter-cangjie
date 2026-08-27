/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.net.tls.common.TlsException

extend TlsRawSocket {
    /**
     * @throws TlsException while tls socket is not connected.
     * @throws IllegalMemoryException if malloc failed.
     */
    func getAlpnSelected(): ?String {
        unsafe {
            let protoCCp = LibC.malloc<CPointer<Byte>>(count: 1)
            if (protoCCp.isNull()) {
                throw IllegalMemoryException("Failed to allocate memory.")
            }
            let lenCp = LibC.malloc<UInt32>(count: 1)
            if (lenCp.isNull()) {
                LibC.free(protoCCp)
                throw IllegalMemoryException("Failed to allocate memory.")
            }

            lenCp.write(0)
            protoCCp.write(CPointer())

            try {
                otherNonIO<Unit> {
                    stream, _ => CJ_TLS_GetAlpnSelected(stream, protoCCp, lenCp)
                }

                var protoCp: CPointer<Byte> = protoCCp.read(0)
                var len: Int64 = Int64(lenCp.read(0))
                if (protoCp.isNull() || len == 0) {
                    return None
                }

                // the string is not a zero-terminated string, can't use CString
                let item: Array<Byte> = Array<Byte>(len, repeat: 0)
                copy(source: protoCp, destination: item, count: UIntNative(len))

                return String.fromUtf8(item)
            } finally {
                LibC.free(CPointer<Unit>(protoCCp))
                LibC.free(CPointer<Unit>(lenCp))
            }
        }
    }
}

/*
 * @throws TlsException while the client alpn protocol is set failed.
 */
func setClientAlpnProtos(clientCtx: CPointer<Ctx>, alpnList: Array<String>): Unit {
    if (alpnList.isEmpty()) {
        return
    }
    var buf = alpnListToByteArray(alpnList)
    unsafe {
        var cph = acquireArrayRawData(buf)
        try {
            var ret = CJ_TLS_SetClientAlpnProtocols(clientCtx, cph.pointer, UInt32(buf.size))
            if (ret == -1) {
                throw TlsException("Failed to set client alpn protocol.")
            }
        } finally {
            releaseArrayRawData(cph)
        }
    }
}

/*
 * @throws TlsException while the server alpn protocol is set failed.
 */
func setServerAlpnProtos(serverCtx: CPointer<Ctx>, alpnList: Array<String>): Unit {
    if (alpnList.isEmpty()) {
        return
    }
    var buf = alpnListToByteArray(alpnList)
    unsafe {
        var cph = acquireArrayRawData(buf)
        try {
            var ret = CJ_TLS_SetServerAlpnProtos(serverCtx, cph.pointer, UInt32(buf.size))
            if (ret <= 0) {
                throw TlsException("Failed to set server alpn protocol.")
            }
        } finally {
            releaseArrayRawData(cph)
        }
    }
}

/*
 * @throws TlsException while The length of the alpn protocol is more than 255.
 */
func alpnListToByteArray(alpnList: Array<String>): Array<Byte> {
    var bufLen = 0
    for (s in alpnList) {
        var ss = s.size
        if (ss > 255) {
            throw TlsException("The length of the alpn protocol must be less than 255.")
        }
        bufLen = bufLen + 1 + ss
    }
    var buf = Array<Byte>(bufLen, repeat: 0)

    var bufIndex = 0
    for (s in alpnList) {
        let view = unsafe { s.rawData() }
        let ss = view.size
        buf[bufIndex] = UInt8(ss)
        bufIndex++
        view.copyTo(buf, 0, bufIndex, ss)
        bufIndex += ss
    }
    return buf
}

@C
struct DynMsg {
    var found = true
    var funcName = CPointer<UInt8>()
}

foreign {
    func CJ_TLS_DYN_GetAlpnSelected(aStream: CPointer<Ssl>, proto: CPointer<CPointer<Byte>>, len: CPointer<UInt32>,
        dynMsgPtr: CPointer<DynMsg>): Unit

    func CJ_TLS_DYN_SetClientAlpnProtocols(ctx: CPointer<Ctx>, protos: CPointer<Byte>, protosLen: UInt32,
        dynMsgPtr: CPointer<DynMsg>): Int32

    func CJ_TLS_DYN_SetServerAlpnProtos(ctx: CPointer<Ctx>, protos: CPointer<Byte>, protosLen: UInt32,
        dynMsgPtr: CPointer<DynMsg>): Int32
}

func CJ_TLS_SetClientAlpnProtocols(ctx: CPointer<Ctx>, protos: CPointer<Byte>, protosLen: UInt32): Int32 {
    unsafe {
        var dynMsg: DynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetClientAlpnProtocols(ctx, protos, protosLen, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_GetAlpnSelected(aStream: CPointer<Ssl>, proto: CPointer<CPointer<Byte>>, len: CPointer<UInt32>): Unit {
    unsafe {
        var dynMsg = DynMsg()
        CJ_TLS_DYN_GetAlpnSelected(aStream, proto, len, inout dynMsg)
        checkDynMsg(dynMsg)
    }
}

func CJ_TLS_SetServerAlpnProtos(ctx: CPointer<Ctx>, protos: CPointer<Byte>, protosLen: UInt32): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetServerAlpnProtos(ctx, protos, protosLen, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}
