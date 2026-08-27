/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.time.DateTime
import std.convert.RadixConvertible

private const OCTAL = 8
private const CHECKSUM_REAL_MAX = FieldLocation.CHECKSUM.length - 2

extend Int32 {
    func encodeChecksumTo(target: Array<UInt8>): Unit {
        if (target.size != FieldLocation.CHECKSUM.length) {
            throw TarException("Checksum target array must be of size ${FieldLocation.CHECKSUM.length} can not be ${target.size}.")
        }

        let s = this.toString(radix: OCTAL)
        if (s.size > CHECKSUM_REAL_MAX) {
            throw TarException("Value ${this} too long to encode octal in field of size ${CHECKSUM_REAL_MAX}.")
        }
        if (s.size == CHECKSUM_REAL_MAX) {
            target[0] = b'0'
            target[1..=CHECKSUM_REAL_MAX] = unsafe { s.rawData() }
        } else {
            target[..CHECKSUM_REAL_MAX - s.size].fill(b'0')
            target[CHECKSUM_REAL_MAX - s.size..CHECKSUM_REAL_MAX] = unsafe { s.rawData() }
            target[CHECKSUM_REAL_MAX] = b'\0'
        }
        target[CHECKSUM_REAL_MAX + 1] = b' '
    }

    func encodeOcatalTo(target: Array<UInt8>): Unit {
        var s = this.toString(radix: OCTAL)
        if (s.size > target.size) {
            throw TarException("Value ${this} too long to encode octal in field of size ${target.size}.")
        }
        s = s.padStart(target.size - 1, padding: '0')

        var index = 0
        while (index < target.size) {
            if (index < s.size) {
                target[index] = s[index]
            } else if (index == s.size) {
                target[index] = b'\0'
            } else {
                target[index] = b' '
            }
            index++
        }
    }
}

extend Int64 {
    func encodeOcatalTo(target: Array<UInt8>): Unit {
        var s = this.toString(radix: OCTAL)
        if (s.size > target.size) {
            throw TarException("Value ${this} too long to encode octal in field of size ${target.size}.")
        }
        s = s.padStart(target.size - 1, padding: '0')

        var index = 0
        while (index < target.size) {
            if (index < s.size) {
                target[index] = s[index]
            } else {
                target[index] = b'\0'
            }
            index++
        }
    }
}

extend DateTime {
    func encodeTo(target: Array<UInt8>): Unit {
        const TIMESTAMP_MAX = 0o777777777777
        let seconds = this.toUnixTimeStamp().toSeconds()
        if (seconds > TIMESTAMP_MAX) {
            throw TarException("Timestamp ${this} too long to encode in field.")
        }
        if (seconds < 0) {
            throw TarException("Timestamp ${this} is negative.")
        }
        seconds.encodeOcatalTo(target)
    }
}

extend String {
    func encodeTo(target: Array<UInt8>): Unit {
        let bytes = unsafe { this.rawData() }
        if (bytes.size > target.size) {
            throw TarException("String '${this}' too long to fit in field which size = ${target.size}.")
        }
        var index = 0
        while (index < bytes.size) {
            target[index] = bytes[index]
            index++
        }
        while (index < target.size) {
            target[index] = b'\0'
            index++
        }
    }
}
