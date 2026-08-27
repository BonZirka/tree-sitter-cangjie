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

public class SHA1 <: Digest {
    var sha1Ctx: SHACTX
    var hasFinished: Bool

    public init() {
        sha1Ctx = SHACTX()
        this.hasFinished = false
    }

    public prop size: Int64 {
        get() {
            return SHA1_DIGEST_LENGTH
        }
    }

    public prop blockSize: Int64 {
        get() {
            return SHA1_BLOCK_SIZE
        }
    }

    public prop algorithm: String {
        get() {
            return SHA1_DIGEST_ALGORITHM_NAME
        }
    }

    public func write(buffer: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("SHA1 write failed, digest calculation has been completed.")
        }
        sha1Update(sha1Ctx, buffer)
    }

    public func finish(): Array<Byte> {
        var md = Array<Byte>(this.size, repeat: 0)
        finish(to: md)
        md
    }

    public func finish(to!: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("SHA1 finish failed, digest calculation has been completed.")
        }
        if (to.size != size) {
            throw CryptoException("The length of output is not equal to the digest length.")
        }
        sha1Final(sha1Ctx, to)
        this.hasFinished = true
    }

    public func reset(): Unit {
        sha1Init(this.sha1Ctx.ptr)
        this.hasFinished = false
    }
}

func sha1Update(c: SHACTX, data: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(data)
        let res = try {
            DYN_SHA1_Update(c.ptr, p.pointer, UIntNative(data.size), dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("SHA1 write error")
        }
    }
}

func sha1Final(c: SHACTX, md: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(md)
        let res = try {
            DYN_SHA1_Final(p.pointer, c.ptr, dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("SHA1 finish error")
        }
    }
}
