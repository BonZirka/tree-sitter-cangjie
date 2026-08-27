/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.crypto

import std.math.*
import std.sync.*
import stdx.crypto.common.RandomGenerator

public class SecureRandomException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "SecureRandomException"
    }
}

const CRYPTO_ERR = 0_i32
const CRYPTO_NOT_SUPPORTED = -1_i32

@FastNative
foreign func DYN_RAND_bytes(buf: CPointer<Byte>, len: Int32, msg: CPointer<DynMsg>): Int32

@FastNative
foreign func DYN_RAND_priv_bytes(buf: CPointer<Byte>, len: Int32, msg: CPointer<DynMsg>): Int32

@FastNative
foreign func MallocDynMsg(): CPointer<DynMsg>

@FastNative
foreign func FreeDynMsg(dynMsgPtr: CPointer<DynMsg>): Unit

@C
struct DynMsg {
    var found = true
    var funcName = CPointer<UInt8>()
}

/**
 * A class for cryptographically-secure pseudo-random number generator (CSPRNG).
 * This class is able to produce cryptographically strong random numbers.
 * Compared with `std.random.Random`:
 * - Seed: `Random` uses the system clock as the default seed, which is vulnerale because random numbers can be reproduced if the timestamp is attacked and known.
 *          However, `SecureRandom` takes seeds from the OS or hardware, which is almost true random numbers.
 * - Generation: `Random` implements a Mersenne Twister pseudo-random number generator.
 *               Whereas `SecureRandom` utilizes the openssl library, which may use MD5 (by default) to generate random numbers over a true random number (uses an entropy source).
 *               If supported, openssl can further utilize hardware random number generators that are able to generate stronger random numbers.
 * - Security: `Random` must not be used either for security-critical applications or for protecting sensitive data.
 */
public class SecureRandom <: RandomGenerator {
    /**
     * Initialize with default random seeds.
     * @param `priv` whether to use a separate "private" PRNG instance.
     * There are two thread-local PRNG instances, i.e., the public and the private.
     * The private one is used for secrets like session keys and private keys for certificates.
     */
    private var isPriv = false
    private var nextGaussian = Option<Float64>.None
    private let lock: Mutex = Mutex()

    public init(priv!: Bool = false) {
        isPriv = priv
    }

    /*
     * @throws SecureRandomException if the argument equals to CRYPTO_ERR or CRYPTO_NOT_SUPPORTED.
     */
    private func okOrThrow(ret: Int32): Unit {
        if (ret == CRYPTO_ERR) {
            throw SecureRandomException("Generation failure.")
        }
        if (ret == CRYPTO_NOT_SUPPORTED) {
            throw SecureRandomException("Uninitialized.")
        }
    }

    /**
     * Fill the byte array with cryptographically strong random bytes.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextBytes(bytes: Array<Byte>): Unit {
        let length = Int32(bytes.size)
        unsafe {
            let dynMsgPtr = MallocDynMsg()
            if (dynMsgPtr.isNull()) {
                throw SecureRandomException("Malloc failed.")
            }
            var cph = acquireArrayRawData(bytes)
            var ret = try {
                if (isPriv) {
                    DYN_RAND_priv_bytes(cph.pointer, length, dynMsgPtr)
                } else {
                    DYN_RAND_bytes(cph.pointer, length, dynMsgPtr)
                }
            } finally {
                releaseArrayRawData(cph)
            }
            try {
                if (!dynMsgPtr.read().found) {
                    let funcName = CString(dynMsgPtr.read().funcName).toString()
                    throw SecureRandomException("Can not load openssl library or function ${funcName}.")
                }
            } finally {
                FreeDynMsg(dynMsgPtr)
            }
            okOrThrow(ret)
        }
    }

    /**
     * Generate an array of cryptographically strong random bytes, whose length is specified by the @param `length`.
     *
     * @throws IllegalArgumentException if the argument `length` is not positive.
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextBytes(length: Int32): Array<Byte> {
        if (length <= 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        var bytes = Array<Byte>(Int64(length), repeat: 0)
        nextBytes(bytes)
        return bytes
    }

    /**
     * Generate an array of cryptographically strong random bytes, whose length is specified by the @param `length`.
     *
     * @throws IllegalArgumentException if the argument `bits` is greater than 64 or equal to 0.
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextBits(bits: UInt64): UInt64 {
        if (bits > 64) {
            throw IllegalArgumentException("Bits must be less than or equal to 64.")
        }
        if (bits == 0) {
            throw IllegalArgumentException("Bits cannot be 0.")
        }
        // Calculate the number of bytes required for bits
        var bytes = nextBytes((Int32(bits) - 1) / 8 + 1)
        var result: UInt64 = 0
        for (byte in bytes) {
            result = (result << 8) + UInt64(byte)
        }
        if (bits == 64) {
            return result
        }
        return result & ((1u64 << bits) - 1)
    }

    /**
     * Get a random value of `Bool`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextBool(): Bool {
        var bytes: UInt64 = nextUInt64()
        return (bytes & UInt64(1)) == 0
    }

    /**
     * Get a random value of `UInt8`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextUInt8(): UInt8 {
        var bytes: UInt64 = nextUInt64()
        return UInt8(bytes & UInt64(0xFF))
    }

    /**
     * Get a random value of `UInt16`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextUInt16(): UInt16 {
        var bytes: UInt64 = nextUInt64()
        return UInt16(bytes & UInt64(0xFFFF))
    }

    /**
     * Get a random value of `UInt32`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextUInt32(): UInt32 {
        var bytes: UInt64 = nextUInt64()
        return UInt32(bytes & UInt64(0xFFFF_FFFF))
    }

    /**
     * Get a random value of `UInt64`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextUInt64(): UInt64 {
        var value = nextBytes(8)
        var result: UInt64 = 0
        for (val in value) {
            result <<= 8
            result += UInt64(val)
        }
        return result
    }

    /**
     * Get a random value of `Int8`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextInt8(): Int8 {
        return Int8(nextUInt8())
    }

    /**
     * Get a random value of `Int16`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextInt16(): Int16 {
        return Int16(nextUInt16())
    }

    /**
     * Get a random value of `Int32`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextInt32(): Int32 {
        return Int32(nextUInt32())
    }

    /**
     * Get a random value of `Int64`.
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    @OverflowWrapping
    public func nextInt64(): Int64 {
        return Int64(nextUInt64())
    }

    /**
     * Get a random value of `UInt8` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` equals to 0
     */
    public func nextUInt8(max: UInt8): UInt8 {
        if (max == 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: UInt16 = 256 // UInt8.Max + 1
        let threshold: UInt16 = range - range % UInt16(max)
        var value: UInt8
        do {
            value = nextUInt8()
        } while (UInt16(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `UInt16` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` equals to 0
     */
    public func nextUInt16(max: UInt16): UInt16 {
        if (max == 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: UInt32 = 65536 // UInt16.Max + 1
        let threshold: UInt32 = range - range % UInt32(max)
        var value: UInt16
        do {
            value = nextUInt16()
        } while (UInt32(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `UInt32` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` equals to 0
     */
    public func nextUInt32(max: UInt32): UInt32 {
        if (max == 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: UInt64 = 4294967296 // UInt32.Max + 1
        let threshold: UInt64 = range - range % UInt64(max)
        var value: UInt32
        do {
            value = nextUInt32()
        } while (UInt64(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `UInt64` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` equals to 0
     */
    public func nextUInt64(max: UInt64): UInt64 {
        if (max == 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        let limit: UInt64 = UInt64.Max - UInt64.Max % max
        var value: UInt64
        do {
            value = nextUInt64()
        } while (value >= limit)
        return value % max
    }

    /**
     * Get a random value of `Int8` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` is not positive
     */
    public func nextInt8(max: Int8): Int8 {
        if (max <= 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: Int16 = 128 // Int8.Max + 1
        let threshold: Int16 = range - range % Int16(max)
        var value: Int8
        do {
            value = nextInt8()
        } while (value < 0 || Int16(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `Int16` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` is not positive
     */
    public func nextInt16(max: Int16): Int16 {
        if (max <= 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: Int32 = 32768 // Int16.Max + 1
        let threshold: Int32 = range - range % Int32(max)
        var value: Int16
        do {
            value = nextInt16()
        } while (value < 0 || Int32(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `Int32` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` is not positive.
     */
    public func nextInt32(max: Int32): Int32 {
        if (max <= 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        const range: Int64 = 2147483648 // Int32.Max + 1
        let threshold: Int64 = range - range % Int64(max)
        var value: Int32
        do {
            value = nextInt32()
        } while (value < 0 || Int64(value) >= threshold)
        return value % max
    }

    /**
     * Get a random value of `Int64` in [0, max).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @throws IllegalArgumentException if the argument `max` is not positive.
     */
    public func nextInt64(max: Int64): Int64 {
        if (max <= 0) {
            throw IllegalArgumentException("Invalid argument.")
        }
        let limit: Int64 = Int64.Max - Int64.Max % max
        var value: Int64
        do {
            value = nextInt64()
        } while (value < 0 || value >= limit)
        return value % max
    }

    /**
     * Get a random value of `Float16` in [0.0, 1.0).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextFloat16(): Float16 {
        return Float16(Float64(nextUInt16() & UInt16((1 << 11) - 1)) / Float64(1 << 11))
    }

    /**
     * Get a random value of `Float32` in [0.0, 1.0).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextFloat32(): Float32 {
        return Float32(Float64(nextUInt32() & UInt32((1 << 24) - 1)) / Float64(1 << 24))
    }

    /**
     * Get a random value of `Float64` in [0.0, 1.0).
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     */
    public func nextFloat64(): Float64 {
        return Float64(Float64(nextUInt64() & UInt64((1 << 53) - 1)) / Float64(1 << 53))
    }

    /**
     * Obtains random values with Gaussian (normal) distribution.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float16 random value
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @since 0.40.2
     */
    public func nextGaussianFloat16(mean!: Float16 = 0.0, sigma!: Float16 = 1.0): Float16 {
        return Float16(nextGaussianFloat64()) * sigma + mean
    }

    /**
     * Obtains random values with Gaussian (normal) distribution.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float32 random value
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @since 0.40.2
     */
    public func nextGaussianFloat32(mean!: Float32 = 0.0, sigma!: Float32 = 1.0): Float32 {
        return Float32(nextGaussianFloat64()) * sigma + mean
    }

    /**
     * Obtains random values with Gaussian (normal) distribution.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float64 random value
     *
     * @throws SecureRandomException if the generator is not properly seeded, or if the generation fails.
     * @since 0.40.2
     */
    public func nextGaussianFloat64(mean!: Float64 = 0.0, sigma!: Float64 = 1.0): Float64 {
        return gaussian() * sigma + mean
    }

    /**
     * Box-Muller algorithm
     * R * cos(O) or R * sin(O), it's a pair of Gaussian random numbers.
     * when R = sqrt(-2 * ln(V1)) and  O = 2 * π * V2.
     * V1 and V2 are two evenly distributed random numbers.
     */
    private func gaussian(): Float64 {
        synchronized(lock) {
            match (nextGaussian) {
                case Some(v) =>
                    nextGaussian = Option<Float64>.None
                    return v
                case None =>
                    var v1: Float64 = nextFloat64()
                    while (v1 == 0.0) {
                        v1 = nextFloat64()
                    }
                    let v2: Float64 = nextFloat64()
                    let r = sqrt(-2.0 * log(v1))
                    let st = 2.0 * Float64.getPI() * v2
                    nextGaussian = Option<Float64>.Some(r * cos(st))
                    return r * sin(st)
            }
        }
    }
}
