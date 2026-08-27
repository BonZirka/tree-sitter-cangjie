/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines some hex to string help methods.
 *
 */

package stdx.encoding.hex

let HEX_ENCODE_CHARS_LOW = "0123456789abcdef".toArray()

/*
 * Converting a hexadecimal array to a set of UInt8 (HexToString decoding).
 *
 * @param data of Array<Rune>.
 * @return Parameters of Option<Array<UInt8>>.
 *
 * @since 0.17.4
 */
func decode(data: Array<UInt8>): Option<Array<UInt8>> {
    var arrLength: Int64 = data.size
    var index: Int64 = 0
    var temp: Array<UInt8> = Array<UInt8>(arrLength / 2, repeat: 0)
    var i: Int64 = 0
    while (i < arrLength) {
        var highFour: UInt8 = unhex(data[i])
        i++
        var lowFour: UInt8 = unhex(data[i])
        i++
        var str: UInt8 = UInt8((highFour << 4) | lowFour)
        temp[index] = str
        index++
    }
    return Option<Array<UInt8>>.Some(temp)
}

@OverflowWrapping
func unhex(c: UInt8): UInt8 {
    match {
        case b'0' <= c && c <= b'9' => UInt8(UInt32(c) - UInt32(r'0'))
        case b'a' <= c && c <= b'f' => UInt8(UInt32(c) - UInt32(r'a') + UInt32(10))
        case b'A' <= c && c <= b'F' => UInt8(UInt32(c) - UInt32(r'A') + UInt32(10))
        case _ => UInt8(0)
    }
}

/*
 * Converts the UInt8 collection to a character string (HexToString encodinkg).
 * ASCII: A (65)
 * Binary code: 0100 _ 0001
 * Regroup: 0000 _ 0100 0000 _ 0001
 * Hexadecimal: 4 1
 * Hex code: 41
 *
 * @param data of Array<UInt8>.
 * @return Parameters of String.
 *
 * @since 0.17.4
 */
func encode(data: Array<UInt8>): String {
    var chrLen: Int64 = data.size
    if (chrLen <= 0) {
        return ""
    }
    var chs: Array<UInt8> = Array<UInt8>(chrLen * 2, repeat: 0)
    var index: Int64 = 0
    for (i in 0..chrLen) {
        chs[index] = HEX_ENCODE_CHARS_LOW[Int64(((data[i] & 0xf0) >> 4))]
        index++
        chs[index] = HEX_ENCODE_CHARS_LOW[Int64((data[i] & 0x0f))]
        index++
    }
    return unsafe { String.fromUtf8Unchecked(chs) }
}

func processDataBeforeDecode(data: Array<UInt8>): Array<UInt8> {
    var temp: Array<UInt8> = Array<UInt8>(data.size, repeat: 0)
    var index: Int64 = 0
    for (i in 0..data.size) {
        let ch = data[i]
        if (ch.isAsciiHex()) {
            temp[index] = ch
            index++
        } else if (ch == b'\0') {
            return Array<UInt8>()
        } else if (ch == b'\r' || ch == b'\n' || ch == b' ' || ch == b'\t') {
            continue
        } else {
            return Array<UInt8>()
        }
    }
    if (index <= 0 || index % 2 != 0) {
        return Array<UInt8>()
    }
    return temp[0..index]
}

/**
 * Provides the Hex encoding conversion function and the HexString to ByteArray function. If decoding fails, Option is returned.
 *
 * @param data of String.
 * @return Parameters of Option<Array<UInt8>>.
 *
 * @since 0.17.4
 */
public func fromHexString(data: String): Option<Array<Byte>> {
    var strChArr: Array<UInt8> = unsafe { data.rawData() }
    if (strChArr.size == 0) {
        return Option<Array<UInt8>>.Some(Array<UInt8>())
    }
    var temp: Array<UInt8> = processDataBeforeDecode(strChArr)
    if (temp.size == 0) {
        return Option<Array<UInt8>>.None
    }
    return decode(temp)
}

/**
 * Provides the ByteArray to HexString function. If the encoding fails, Option is returned.
 *
 * @param data of String.
 * @return Parameters of String
 *
 * @since 0.17.4
 */
public func toHexString(data: Array<Byte>): String {
    return encode(data)
}
