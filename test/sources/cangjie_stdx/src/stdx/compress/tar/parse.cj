/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.time.DateTime
import std.convert.{Parsable, RadixConvertible}

// cjlint-ignore -start !G.OTH.03
/**
 * Utility class for parsing GNU Base256 encoded numbers.
 *
 * Specification Reference: https://www.gnu.org/software/tar/manual/html_node/Extensions.html
 *
 * - If the leading byte is 0xff (255), all bytes of the field (including the leading byte)
 *   are concatenated in big-endian order. The result is a negative number expressed
 *   in two's complement form.
 *
 * - If the leading byte is 0x80 (128), the non-leading bytes of the field are concatenated
 *   in big-endian order. The result is a positive number expressed in binary form.
 *
 * - Leading bytes other than 0xff, 0x80, and ASCII octal digits are reserved for future use.
 *   Base-256 representations of values that would be in range for the basic format are also reserved.
 */
// cjlint-ignore -end
private class GnuBase256 {
    private init() { }

    static const POSITIVE_PREFIX: UInt8 = 0x80
    static const NEGATIVE_PREFIX: UInt8 = 0xFF

    private static const BYTE_SIZE = 8

    static func parsePositive(buffer: Array<UInt8>): Int64 {
        var value: Int64 = 0
        for (b in buffer.iterator().skip(1)) {
            value = (value << BYTE_SIZE) | Int64(b)
        }
        return value
    }

    static func parseNegative(buffer: Array<UInt8>): Int64 {
        var value: Int64 = 0
        for (b in buffer) {
            value = (value << BYTE_SIZE) | Int64(b)
        }
        return value - (1 << buffer.size * BYTE_SIZE)
    }
}

extend Int64 {
    static func parseDecimal(buffer: Array<UInt8>): Int64 {
        if (buffer.size == 0) {
            return 0
        }

        let trim = buffer.trimEnd(b'\0', b' ').trimStart(b'\0', b' ')
        if (trim.size == 0) {
            return 0
        }

        return Int64.parse(String.fromUtf8(trim))
    }

    static func parseOctal(buffer: Array<UInt8>): Int64 {
        const OCTAL = 8

        let trim = buffer.trimEnd(b'\0', b' ').trimStart(b'\0', b' ')

        if (trim.size == 0) {
            return 0
        }
        return Int64.parse(String.fromUtf8(trim), radix: OCTAL)
    }

    static func parseNumeric(buffer: Array<UInt8>): Int64 {
        if (buffer.size == 0) {
            return 0
        }
        let leadingByte = buffer[0]
        if (leadingByte == GnuBase256.POSITIVE_PREFIX) {
            return GnuBase256.parsePositive(buffer)
        } else if (leadingByte == GnuBase256.NEGATIVE_PREFIX) {
            return GnuBase256.parseNegative(buffer)
        } else {
            return parseOctal(buffer)
        }
    }
}

extend Int32 {
    static func parseDecimal(buffer: Array<UInt8>): Int32 {
        if (buffer.size == 0) {
            return 0
        }

        let trim = buffer.trimEnd(b'\0', b' ').trimStart(b'\0', b' ')
        if (trim.size == 0) {
            return 0
        }

        return Int32.parse(String.fromUtf8(trim))
    }

    static func parseOctal(buffer: Array<UInt8>): Int32 {
        const OCTAL = 8

        let trim = buffer.trimEnd(b'\0', b' ').trimStart(b'\0', b' ')

        if (trim.size == 0) {
            return 0
        }
        return Int32.parse(String.fromUtf8(trim), radix: OCTAL)
    }

    static func parseNumeric(buffer: Array<UInt8>): Int32
    {
        if (buffer.size == 0) {
            return 0
        }
        let leadingByte = buffer[0]
        if (leadingByte == GnuBase256.POSITIVE_PREFIX) {
            return Int32(GnuBase256.parsePositive(buffer))
        } else if (leadingByte == GnuBase256.NEGATIVE_PREFIX) {
            return Int32(GnuBase256.parseNegative(buffer))
        } else {
            return parseOctal(buffer)
        }
    }
}

func parseTimestamp(buffer: Array<UInt8>): DateTime {
    return DateTime.fromUnixTimeStamp(Int64.parseNumeric(buffer) * Duration.second)
}

func parsePaxTimestamp(buffer: Array<UInt8>): DateTime {
    const DECIMAL_BASE = 10
    const NANOSECOND_DIGITS = 9

    if (buffer.size == 0) {
        return DateTime.UnixEpoch
    }
    let isNegative = buffer[0] == b'-'

    var integerPart = 0
    var decimalPart = 0
    var decimalDigit = 0
    var isDecimal = false

    var i = 0
    if (isNegative) {
        i++
    }
    while (i < buffer.size) {
        let c = buffer[i]
        if (c == b'.') {
            isDecimal = true
            i++
            continue
        }
        if (c < b'0' || c > b'9') {
            throw TarException("Invalid pax timestamp value ${buffer}.")
        }
        if (!isDecimal) {
            integerPart = integerPart * DECIMAL_BASE + Int64(c - b'0')
        } else if (decimalDigit < NANOSECOND_DIGITS) {
            decimalPart = decimalPart * DECIMAL_BASE + Int64(c - b'0')
            decimalDigit++
        } // `else` reaching the upper limit of accuracy (nanosecond)
        i++
    }
    while (decimalDigit < NANOSECOND_DIGITS) {
        decimalPart *= DECIMAL_BASE
        decimalDigit++
    }
    if (isNegative) {
        integerPart = -integerPart
        decimalPart = -decimalPart
    }

    return DateTime.fromUnixTimeStamp(integerPart * Duration.second + decimalPart * Duration.nanosecond)
}

func parseString(buffer: Array<UInt8>): String {
    return String.fromUtf8(buffer.trimEnd(b'\0'))
}
