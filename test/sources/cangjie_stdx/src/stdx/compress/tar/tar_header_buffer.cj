/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.io.{InputStream, OutputStream}

const TAR_BLOCK_SIZE = 512

struct FieldLocation {
    private const FieldLocation(let offset: Int64, let length: Int64) { }

    private const init(last: FieldLocation, length: Int64) {
        this(last.offset + last.length, length)
    }

    private static const NAME_LENGTH = 100

    const func contains(index: Int64): Bool {
        return offset <= index && index < offset + length
    }

    // Common fields
    static const NAME        = FieldLocation(0, NAME_LENGTH)
    static const MODE        = FieldLocation(NAME, 8)
    static const UID         = FieldLocation(MODE, 8)
    static const GID         = FieldLocation(UID, 8)
    static const SIZE        = FieldLocation(GID, 12)
    static const M_TIME      = FieldLocation(SIZE, 12)
    static const CHECKSUM    = FieldLocation(M_TIME, 8)
    static const TYPE_FLAG   = FieldLocation(CHECKSUM, 1)
    static const LINK_NAME   = FieldLocation(TYPE_FLAG, NAME_LENGTH)

    // POSIX and GNU shared fields
    static const MAGIC       = FieldLocation(LINK_NAME, 6)
    static const VERSION     = FieldLocation(MAGIC, 2)
    static const U_NAME      = FieldLocation(VERSION, 32)
    static const G_NAME      = FieldLocation(U_NAME, 32)
    static const DEV_MAJOR   = FieldLocation(G_NAME, 8)
    static const DEV_MINOR   = FieldLocation(DEV_MAJOR, 8)

    // USTAR fields
    static const PREFIX      = FieldLocation(DEV_MINOR, 155)

    // GNU fields
    static const A_TIME      = FieldLocation(DEV_MINOR, 12)
    static const C_TIME      = FieldLocation(A_TIME, 12)
    static const OFFSET      = FieldLocation(C_TIME, 12)
    static const LONG_NAMES  = FieldLocation(OFFSET, 4)
    static const UNUSED      = FieldLocation(LONG_NAMES, 1)
    static const SPARSE      = FieldLocation(UNUSED, 4 * (12 + 12))
    static const IS_EXTENDED = FieldLocation(SPARSE, 1)
    static const REAL_SIZE   = FieldLocation(IS_EXTENDED, 12)
}

struct TarHeaderBuffer {
    static const SIZE = 512

    private let buffer: Array<UInt8>

    init(stream: InputStream) {
        buffer = Array<UInt8>(SIZE, repeat: 0)
        readExactly(stream, buffer)
    }

    init(buffer: Array<UInt8>) {
        if (buffer.size != SIZE) {
            throw TarException("Invalid buffer size ${buffer.size} which must be ${SIZE}.")
        }
        this.buffer = buffer
    }

    init() {
        buffer = Array<UInt8>(SIZE, repeat: 0)
    }

    operator func [](field: FieldLocation): Array<UInt8> {
        return buffer.slice(field.offset, field.length)
    }

    private func calaulateChecksum(): Int32 {
        var sum: Int32 = 0
        for (i in 0..SIZE) {
            let byte = if (FieldLocation.CHECKSUM.contains(i)) {
                b' '
            } else {
                buffer[i]
            }

            sum += Int32(byte)
        }
        return sum
    }

    func readChecksumAndValidate(): ?Int32 {
        let checksumBuffer = this[FieldLocation.CHECKSUM]
        if (checksumBuffer.isAllZero()) {
            return None
        }
        let actural = Int32.parseOctal(checksumBuffer)
        let expected = calaulateChecksum()
        if (expected != actural) {
            throw TarException("Invalid checksum ${actural} (expected ${expected}).")
        }
        return actural
    }

    func writeTo(stream: OutputStream): Unit {
        calaulateChecksum().encodeChecksumTo(this[FieldLocation.CHECKSUM])
        stream.write(buffer)
    }
}
