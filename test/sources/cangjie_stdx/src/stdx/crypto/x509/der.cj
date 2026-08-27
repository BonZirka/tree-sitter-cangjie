/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.time.DateTime
import std.collection.{ArrayList, map}
import stdx.crypto.common.*

const MAX_DER_DEPTH = 32

struct DerField <: ToString {
    DerField(
        let fieldType: DerType,
        let length: Int64,
        let body: Array<Byte>,
        let depth: Int64
    ) {}

    func asSequence(): DerSequence {
        if (fieldType != DerType.SEQUENCE) {
            throw X509Exception("The field is not a sequence: ${fieldType}.")
        }

        DerSequence(body, depth: this.depth + 1)
    }

    func asArrayByte(): Array<Byte> {
        let content = match {
            case fieldType == DerType.ASN_INT => body
            case _ => throw X509Exception("Unsupported field type: ${fieldType}.")
        }
        content
    }

    func asTime(): DateTime {
        let content = match {
            case fieldType == DerType.GENERALIZED_TIME || fieldType == DerType.UTC_TIME => String.fromUtf8(body)
            case _ => throw X509Exception("Unsupported field type: ${fieldType}.")
        }

        let format = match {
            case fieldType == DerType.UTC_TIME => "yyMMddHHmmssOO"
            case fieldType == DerType.GENERALIZED_TIME => "yyyyMMddHHmmssOO"
            case _ => throw X509Exception("Unsupported field type: ${fieldType}.")
        }

        if (!content.endsWith("Z")) {
            throw X509Exception("Illegal date format: ${content}, should be ${format}Z.")
        }

        let stdBuilder = StringBuilder()
        stdBuilder.append(content[..content.size - 1])
        stdBuilder.append("+00:00")
        DateTime.parse(stdBuilder.toString(), format)
    }

    func asString(): String {
        String.fromUtf8(body)
    }

    func checkVersion(): Unit {
        // version type body size should be 3 bytes
        // first byte 0x02 denotes integer
        // second byte 0x01 denotes length
        // third byte is version value {0x01, 0x02}, 0x00 is usually omitted
        if (body.size != 3) {
            throw X509Exception("Invalid version: Invalid version field length.")
        }
        if (body[0] != 0x02 || body[1] != 0x01) {
            throw X509Exception("Invalid version field value.")
        }
        if (body[2] != 0 && body[2] != 1 && body[2] != 2) {
            throw X509Exception("X509Cert init failed: Invalid version value: ${body[2]}. Must be 0, 1, or 2.")
        }
    }

    public override func toString(): String {
        "DER(type = ${fieldType}, length: ${length})"
    }

    prop blob: DerBlob {
        get() {
            var field = ArrayList<Byte>()
            field.add(all: formDerType(fieldType))
            field.add(all: formDerLength(length))
            field.add(all: body)
            DerBlob(field.toArray())
        }
    }

    // X.690 ASN.1 encoding rules
    func formDerType(derType: DerType): ArrayList<Byte> {
        var first: Byte = match (derType.derClass) {
            case Universal => 0
            case Application => 1
            case ContextSpecific => 2
            case Private => 3
        }
        var identifier = derType.typeIdentifier
        var pc = match (derType.primitive) {
            case false => UInt8(1)
            case true => UInt8(0)
        }
        first = (first << 2) | pc
        // low tag number in the range 0 to 30 (inclusive).
        if (identifier <= 30) {
            first = (first << 5) | UInt8(identifier)
            return ArrayList<Byte>.of(first)
        }
        // identifier tag number greater than 30
        first = (first << 5) | 0x1f
        var arr = ArrayList<Byte>.of(first)
        let bytes = ArrayList<Byte>()
        while (identifier > 0) {
            bytes.add(UInt8(identifier & 0x7f))
            identifier = identifier >> 7
        }
        bytes.reverse()
        for (i in 0..bytes.size) {
            if (i < bytes.size - 1) {
                arr.add(bytes[i] | 0x80)
            } else {
                arr.add(bytes[i])
            }
        }
        arr
    }

    func formDerLength(len: Int64): ArrayList<Byte> {
        var length = len
        // length is less than or equal to 127 in short form
        if (length <= 127) {
            return ArrayList<Byte>.of(UInt8(length))
        }
        // length is greater than 127 in long form
        var count: Byte = 0
        var arr = ArrayList<Byte>()
        while (true) {
            let octet: Byte = UInt8(length & 0xff)
            length = length >> 8
            arr.add(octet)
            count++
            if (length == 0) {
                break
            }
        }
        arr.add(UInt8(count | 0x80))
        arr.reverse()
        arr
    }
}
class DerSequence <: Collection<DerField> {
    private let fields: Array<(DerType, Int64)>

    DerSequence(private let body: Array<Byte>, let depth!: Int64 = 0) {
        if (depth > MAX_DER_DEPTH) {
            throw X509Exception("X509 parse failed: DER nesting depth exceeds maximum limit (${MAX_DER_DEPTH}).")
        }
        var parser = DerParser(body)
        let positions = ArrayList<(DerType, Int64)>()

        while (parser.hasRemaining) {
            let offset = parser.at
            let ty = parser.skipDerField()

            positions.add((ty, offset))
        }

        fields = positions.toArray()
    }

    public override prop size: Int64 {
        get() {
            fields.size
        }
    }

    public override func isEmpty(): Bool {
        fields.isEmpty()
    }

    public override func iterator(): Iterator<DerField> {
        fields |>
            map {
            it: (DerType, Int64) =>
            let (_, position) = it
            if (position >= body.size) {
                throw X509Exception("X509 parse failed: out of index.")
            }
            var parser = DerParser(body[position..])
            parser.parseNextDerField(depth)
        }
    }

    operator func [](index: Int64): DerField {
        if (index >= fields.size) {
            throw X509Exception("DerSequence index out of bounds.")
        }
        let (_, position) = fields[index]
        if (position >= body.size) {
            throw X509Exception("X509 parse failed: out of index.")
        }
        var parser = DerParser(body[position..])
        parser.parseNextDerField(depth)
    }
}
