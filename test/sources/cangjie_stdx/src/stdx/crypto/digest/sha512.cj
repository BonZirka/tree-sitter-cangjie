/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.digest

import std.crypto.digest.Digest
import stdx.crypto.common.CryptoException

public class SHA512 <: Digest {
    var sha512Ctx: SHA512CTX
    var hasFinished: Bool

    public init() {
        sha512Ctx = SHA512CTX()
        this.hasFinished = false
    }

    public prop size: Int64 {
        get() {
            return SHA512_DIGEST_LENGTH
        }
    }

    public prop blockSize: Int64 {
        get() {
            return SHA512_BLOCK_SIZE
        }
    }

    public prop algorithm: String {
        get() {
            return SHA512_DIGEST_ALGORITHM_NAME
        }
    }

    public func write(buffer: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("SHA512 write failed, digest calculation has been completed.")
        }
        sha512Update(sha512Ctx, buffer)
    }

    public func finish(): Array<Byte> {
        var md = Array<Byte>(this.size, repeat: 0)
        finish(to: md)
        md
    }

    public func finish(to!: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("SHA512 finish failed, digest calculation has been completed.")
        }
        if (to.size != size) {
            throw CryptoException("The length of output is not equal to the digest length.")
        }
        sha512Final(sha512Ctx, to)
        this.hasFinished = true
    }

    public func reset(): Unit {
        sha512Init(this.sha512Ctx.ptr)
        this.hasFinished = false
    }
}

func sha512Update(c: SHA512CTX, data: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(data)
        let res = try {
            DYN_SHA512_Update(c.ptr, p.pointer, UIntNative(data.size), dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("SHA512 write error.")
        }
    }
}

func sha512Final(c: SHA512CTX, md: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(md)
        let res = try {
            DYN_SHA512_Final(p.pointer, c.ptr, dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("SHA512 finish error.")
        }
    }
}
