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

public struct HashType <: ToString & Equatable<HashType> {
    private var hashType: String

    init(hashType: String) {
        this.hashType = hashType
    }

    public static prop MD5: HashType {
        get() {
            HashType(MD5_DIGEST_ALGORITHM_NAME)
        }
    }

    public static prop SHA1: HashType {
        get() {
            HashType(SHA1_DIGEST_ALGORITHM_NAME)
        }
    }

    public static prop SHA224: HashType {
        get() {
            HashType(SHA224_DIGEST_ALGORITHM_NAME)
        }
    }

    public static prop SHA256: HashType {
        get() {
            HashType(SHA256_DIGEST_ALGORITHM_NAME)
        }
    }

    public static prop SHA384: HashType {
        get() {
            HashType(SHA384_DIGEST_ALGORITHM_NAME)
        }
    }

    public static prop SHA512: HashType {
        get() {
            HashType(SHA512_DIGEST_ALGORITHM_NAME)
        }
    }
    public static prop SM3: HashType {
        get() {
            HashType(SM3_DIGEST_ALGORITHM_NAME)
        }
    }

    public func toString(): String {
        return hashType
    }

    public override operator func ==(other: HashType): Bool {
        hashType == other.hashType
    }

    public override operator func !=(other: HashType): Bool {
        hashType != other.hashType
    }
}

func getHashName(digest: Digest): String {
    match (digest) {
        case _: SHA1 => SHA1_DIGEST_ALGORITHM_NAME
        case _: SHA224 => SHA224_DIGEST_ALGORITHM_NAME
        case _: SHA256 => SHA256_DIGEST_ALGORITHM_NAME
        case _: SHA384 => SHA384_DIGEST_ALGORITHM_NAME
        case _: SHA512 => SHA512_DIGEST_ALGORITHM_NAME
        case _: MD5 => MD5_DIGEST_ALGORITHM_NAME
        case _: SM3 => SM3_DIGEST_ALGORITHM_NAME
        case _ => throw CryptoException("This hash is not supported.")
    }
}

func getHash(algorithm: HashType): () -> Digest {
    match (algorithm.toString()) {
        case "SHA1" => {=> SHA1()}
        case "SHA224" => {=> SHA224()}
        case "SHA256" => {=> SHA256()}
        case "SHA384" => {=> SHA384()}
        case "SHA512" => {=> SHA512()}
        case "MD5" => {=> MD5()}
        case "SM3" => {=> SM3()}
        case _ => throw CryptoException("This hash is not supported.")
    }
}

/**
 * init、write、finish reset Combined use for digest encryption.
 */
public class HMAC <: Digest {
    private var ctxPtr: CPointer<Unit>
    private var hashName: String
    private var hash: Digest
    private var hasFinished: Bool = false
    private var key: Array<Byte>

    public prop size: Int64 {
        get() {
            return hash.size
        }
    }

    public prop blockSize: Int64 {
        get() {
            return hash.blockSize
        }
    }

    public prop algorithm: String {
        get() {
            return "HMAC-${hashName}"
        }
    }

    /*
     * Hmac digest calculation initialization
     *
     * @params key - secret key
     * @params digest - func Digest
     *
     * @throw CryptoException
     */
    public init(key: Array<Byte>, digest: () -> Digest) {
        this.hash = digest()
        this.hashName = getHashName(this.hash)
        if (key.size <= 0) {
            throw CryptoException("The key cannot be empty.")
        }
        this.key = key.clone()
        var ctxPtr = hmacCtxNew()
        if (ctxPtr.isNull()) {
            throw CryptoException("HMAC init failed, malloc failed.")
        }
        this.ctxPtr = ctxPtr
        hmacInitC(this.ctxPtr, this.key, Int32(this.key.size), this.hashName)
        this.hasFinished = false
    }

    /*
     * Hmac digest calculation initialization
     *
     * @params key - secret key
     * @params algorithm - HashType Type
     *
     * @throw CryptoException
     */
    public init(key: Array<Byte>, algorithm: HashType) {
        let digest = getHash(algorithm)

        if (key.size <= 0) {
            throw CryptoException("The key cannot be empty.")
        }
        this.hashName = algorithm.toString()
        this.key = key.clone()
        this.hash = digest()
        var ctxPtr = hmacCtxNew()
        if (ctxPtr.isNull()) {
            throw CryptoException("HMAC init failed, malloc failed.")
        }
        this.ctxPtr = ctxPtr
        hmacInitC(this.ctxPtr, this.key, Int32(this.key.size), this.hashName)
        this.hasFinished = false
    }

    ~init() {
        if (!this.hasFinished) {
            hmacCtxFree(this.ctxPtr)
        }
        key.fill(0)
    }

    /*
     * Perform summary calculation. This function can be run multiple times to summarize multiple data.
     *
     * @params data - Data requiring HMAC operation
     *
     * @throw CryptoException
     */
    public func write(buffer: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("HMAC write failed, digest calculation has been completed.")
        }
        hmacUpdateC(this.ctxPtr, buffer, UIntNative(buffer.size))
    }

    /*
     * Perform summary calculation and use it together with write.
     *
     * @return Array<Byte>
     * @throw CryptoException
     */
    public func finish(): Array<Byte> {
        var md: Array<Byte> = Array<Byte>(size, repeat: 0)
        finish(to: md)
        return md
    }

    public func finish(to!: Array<Byte>): Unit {
        if (this.hasFinished) {
            throw CryptoException("HMAC finish failed, digest calculation has been completed.")
        }
        if (to.size != size) {
            throw CryptoException("The length of output is not equal to the digest length.")
        }
        hmacFinalC(this.ctxPtr, to)
        this.hasFinished = true
        this.ctxPtr = CPointer<Unit>()
    }

    /*
     * Reset Hmac status to recalculate summary.
     *
     * @throw CryptoException
     */
    public func reset(): Unit {
        if (!this.hasFinished) {
            hmacCtxFree(this.ctxPtr)
        }
        var ctxPtr = hmacCtxNew()
        if (ctxPtr.isNull()) {
            throw CryptoException("HMAC malloc failed.")
        }
        this.ctxPtr = ctxPtr
        hmacInitC(this.ctxPtr, this.key, Int32(this.key.size), this.hashName)
        this.hasFinished = false
    }

    /*
     * Hmac digest compare without leaking timing information.
     *
     * @params mac1
     * @params mac1
     *
     * @return Bool
     */
    @OverflowWrapping
    public static func equal(mac1: Array<Byte>, mac2: Array<Byte>): Bool {
        if (mac1.size != mac2.size) {
            return false
        }
        let ptr1 = unsafe { acquireArrayRawData(mac1) }
        let ptr2 = unsafe { acquireArrayRawData(mac2) }
        let res = try {
            cryptoMemcmp(ptr1.pointer, ptr2.pointer, UIntNative(mac1.size)) == 0
        } finally {
            unsafe {
                releaseArrayRawData(ptr1)
                releaseArrayRawData(ptr2)
            }
        }
        return res
    }
}

func hmacInitC(ctx: CPointer<Unit>, key: Array<Byte>, len: Int32, algorithm: String): Unit {
    unsafe {
        let algorithmCstr: CString = LibC.mallocCString(algorithm.toString())
        var md: CPointer<Unit> = CPointer<Unit>()
        try {
            md = getDigestbyname(algorithmCstr)
        } finally {
            LibC.free(algorithmCstr)
        }
        let dynMsgPtr = generateDynMsg()
        let keyptr: CPointerHandle<UInt8> = acquireArrayRawData(key)
        let res = try {
            DYN_HMAC_Init_ex(ctx, keyptr.pointer, len, md, CPointer<Unit>(), dynMsgPtr)
        } finally {
            releaseArrayRawData(keyptr)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("HMAC init failed.")
        }
    }
}

func hmacUpdateC(ctx: CPointer<Unit>, data: Array<Byte>, len: UIntNative): Unit {
    unsafe {
        let dynMsgPtr = generateDynMsg()
        let dataptr: CPointerHandle<UInt8> = acquireArrayRawData(data)
        let res = try {
            DYN_HMAC_Update(ctx, dataptr.pointer, len, dynMsgPtr)
        } finally {
            releaseArrayRawData(dataptr)
        }
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("HMAC write failed.")
        }
    }
}

func hmacFinalC(ctx: CPointer<Unit>, md: Array<Byte>): Unit {
    unsafe {
        var len: UInt32 = 0
        let dynMsgPtr = generateDynMsg()
        let mdptr: CPointerHandle<UInt8> = acquireArrayRawData(md)
        let res = try {
            DYN_HMAC_Final(ctx, mdptr.pointer, inout len, dynMsgPtr)
        } finally {
            releaseArrayRawData(mdptr)
        }
        hmacCtxFree(ctx)
        checkError(dynMsgPtr)
        if (res != 1) {
            throw CryptoException("HMAC finish failed.")
        }
    }
}
