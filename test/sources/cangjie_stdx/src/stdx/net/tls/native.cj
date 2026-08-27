/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.net.tls.common.TlsException

const CJTLS_EOF: Int32 = 0
const CJTLS_FAIL: Int32 = -1
const CJTLS_NEED_READ: Int32 = -2
const CJTLS_NEED_WRITE: Int32 = -3
const CJTLS_OK: Int32 = 1

@C
struct Ssl {}

@C
struct Ctx {}

/**
typedef struct ExceptionDataS {
    const char* message; // this is always allocated using malloc
    const char* constMessage; // this is never allocated
} ExceptionData;
 */
@C
struct ExceptionData {
    var message: CPointer<Byte> = CPointer()
    var constMessage: CPointer<Byte> = CPointer()

    prop hasException: Bool {
        get() {
            !message.isNull() || !constMessage.isNull()
        }
    }

    func throwException(fallback!: String): Nothing {
        throw getException(fallback: fallback)
    }

    func getException(fallback!: String): TlsException {
        if (!message.isNull()) {
            return TlsException(CString(message).toString())
        }
        if (!constMessage.isNull()) {
            return TlsException(CString(constMessage).toString())
        }

        return TlsException(fallback)
    }

    mut func clear(): Unit {
        if (!message.isNull()) {
            unsafe { CRYPTO_free(message) }
            message = CPointer()
        }
    }

    static func create(): CPointer<ExceptionData> {
        unsafe {
            let ptr = LibC.malloc<ExceptionData>(count: 1)
            if (ptr.isNull()) {
                throw IllegalMemoryException("Memory malloc failed.")
            }
            ptr.write(ExceptionData())
            return ptr
        }
    }

    static func free(exception: CPointer<ExceptionData>): Unit {
        unsafe {
            if (exception.isNull()) {
                return
            }

            var data = exception.read()
            data.clear()
            LibC.free(exception)
        }
    }

    static func withException<R>(block: (CPointer<ExceptionData>) -> R): R {
        let exception = ExceptionData.create()
        try {
            block(exception)
        } finally {
            ExceptionData.free(exception)
        }
    }
}

foreign {
    func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

    func MallocDynMsg(): CPointer<DynMsg>

    func FreeDynMsg(dynMsgPtr: CPointer<DynMsg>): Unit

    func CJ_TLS_DYN_CheckPrivateKey(ctx: CPointer<Ctx>, dynMsgPtr: CPointer<DynMsg>): Int32

    func CJ_TLS_DYN_SetProtoVersions(ctx: CPointer<Ctx>, min: Int32, max: Int32, dynMsgPtr: CPointer<DynMsg>): Int32

    func CJ_TLS_DYN_GetVersion(stream: CPointer<Ssl>, dynMsgPtr: CPointer<DynMsg>): CString

    func CJ_TLS_DYN_GetHostName(stream: CPointer<Ssl>, dynMsgPtr: CPointer<DynMsg>): CString

    func CJ_TLS_DYN_SetHostName(
        stream: CPointer<Ssl>,
        name: CString,
        exception: CPointer<ExceptionData>,
        dynMsgPtr: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_SetHostNameForVerify(
        stream: CPointer<Ssl>,
        name: CString,
        dynMsgPtr: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_ServerEnableSNI(context: CPointer<Ctx>, dynMsgPtr: CPointer<DynMsg>): Int32
}

func CJ_TLS_CheckPrivateKey(ctx: CPointer<Ctx>): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_CheckPrivateKey(ctx, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetHostName(
    stream: CPointer<Ssl>,
    name: CString,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetHostName(stream, name, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetHostNameForVerify(stream: CPointer<Ssl>, name: CString): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetHostNameForVerify(stream, name, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_ServerEnableSNI(context: CPointer<Ctx>): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_ServerEnableSNI(context, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_GetHostName(stream: CPointer<Ssl>): CString {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_GetHostName(stream, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetProtoVersions(ctx: CPointer<Ctx>, min: Int32, max: Int32): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetProtoVersions(ctx, min, max, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_GetVersion(stream: CPointer<Ssl>): CString {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_GetVersion(stream, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}
