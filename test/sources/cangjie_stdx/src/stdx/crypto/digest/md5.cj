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

public class MD5 <: Digest {
    var md5Ctx: MD5CTX
    var hasFinished: Bool

    public init() {
        md5Ctx = MD5CTX()
        this.hasFinished = false
    }

    public prop size: Int64 {
        get() {
            return MD5_DIGEST_LENGTH
        }
    }

    public prop blockSize: Int64 {
        get() {
            return MD5_BLOCK_SIZE
        }
    }

    public prop algorithm: String {
        get() {
            return MD5_DIGEST_ALGORITHM_NAME
        }
    }

    public func write(buffer: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("MD5 write failed, digest calculation has been completed.")
        }
        md5Update(md5Ctx, buffer)
    }

    public func finish(): Array<Byte> {
        var md = Array<Byte>(this.size, repeat: 0)
        finish(to: md)
        md
    }

    public func finish(to!: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("MD5 finish failed, digest calculation has been completed.")
        }
        if (to.size != size) {
            throw CryptoException("The length of output is not equal to the digest length.")
        }
        md5Final(md5Ctx, to)
        this.hasFinished = true
    }

    public func reset(): Unit {
        md5Init(this.md5Ctx.ptr)
        this.hasFinished = false
    }
}

func md5Update(c: MD5CTX, data: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(data)
        let res = try {
            DYN_MD5_Update(c.ptr, p.pointer, UIntNative(data.size), dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("MD5 write error")
        }
    }
}

func md5Final(c: MD5CTX, md: Array<Byte>): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let p: CPointerHandle<Byte> = acquireArrayRawData(md)
        let res = try {
            DYN_MD5_Final(p.pointer, c.ptr, dynMsgPtr)
        } finally {
            releaseArrayRawData(p)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("MD5 finish error")
        }
    }
}
