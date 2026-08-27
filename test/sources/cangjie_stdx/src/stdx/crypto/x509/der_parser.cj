/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.collection.ArrayList
import stdx.crypto.common.*

// ITU X.690-202102
// this is a specialized parser for X509 DER, not a general purpose
struct DerParser {
    private var offset = 0

    DerParser(private let body: Array<Byte>) {
    }

    prop at: Int64 {
        get() {
            offset
        }
    }

    prop hasRemaining: Bool {
        get() {
            offset < body.size
        }
    }

    func checkOutOfIndex() {
        if (offset >= body.size) {
            throw X509Exception("X509 parse derfield failed: Failed to parse DER.")
        }
    }

    mut func parseNextDerField(depth: Int64): DerField {
        let ty = parseDerType()
        let length = Int64(parseDerLength())
        let content: Array<Byte> = if (length > 0) {
            if (offset + length > body.size) {
                throw X509Exception("X509 parse derfield failed: Failed to parse DER.")
            }
            body[offset..offset + length]
        } else {
            []
        }
        offset += length

        return DerField(ty, length, content, depth)
    }

    mut func skipDerField(): DerType {
        let ty = parseDerType()
        let length = Int64(parseDerLength())
        if (offset + length > body.size) {
            throw X509Exception("X509 parse derfield failed: Failed to parse DER.")
        }
        offset += length

        return ty
    }

    mut func parseDerType(): DerType {
        checkOutOfIndex()
        let first = body[offset]
        let typeIdentifierBits = first & 0x1fu8
        let derClassNum = first >> 6
        let isPrimitive = (first & 0x20u8) == 0

        offset++
        let typeIdentifier = if (typeIdentifierBits == 0x1f) {
            parseDerIntU64()
        } else {
            UInt64(typeIdentifierBits)
        }

        let derClass = match (derClassNum) {
            case 0 => Universal
            case 1 => Application
            case 2 => ContextSpecific
            case 3 => Private
            case _ => throw X509Exception("X509 parse type failed: Impossible class num.")
        }

        DerType(derClass, typeIdentifier, primitive: isPrimitive)
    }

    mut func parseDerIntU64(): UInt64 {
        var result = 0u64
        var iterations = 0
        const maxIterations = 10
        while (true) {
            if (iterations >= maxIterations) {
                throw X509Exception("X509 parse derfield failed: Base-128 integer overflow.")
            }
            checkOutOfIndex()
            let next = body[offset]
            offset++
            result = (result << 7) | UInt64(next & 0x7fu8)
            if ((next & 0x80u8) == 0) { // leading bit of 0 means the last octet
                break
            }
            iterations++
        }
        return result
    }

    // we can't handle larger fields anyway so we use Int64
    // despite DER supports much bigger
    mut func parseDerLength(): Int64 {
        checkOutOfIndex()
        let first = body[offset]
        if ((first & 0x80) == 0) {
            offset++
            return Int64(first)
        }
        let count = Int64(first & 0x7f)
        if (count == 0) {
            throw X509Exception("X509 parse derfield failed: indefinite length encoding not allowed in DER.")
        }
        let maxDerLength = 7
        if (count > maxDerLength) {
            throw X509Exception("X509 parse derfield failed: unsupport derlength.")
        }
        var result = 0i64
        offset++
        for (_ in 0..count) {
            checkOutOfIndex()
            result = (result << 8) | Int64(body[offset])
            offset++
        }
        if (result > body.size) {
            throw X509Exception("X509 parse derfield failed: Failed to parse DER.")
        }
        if (result < 128) {
            throw X509Exception("X509 parse derfield failed: length must use shortest form in DER.")
        }
        if (result < (1 << (8 * (count - 1)))) {
            throw X509Exception("X509 parse derfield failed: length must use shortest form in DER.")
        }
        return result
    }

    mut func parseDerObjId(): Oid {
        let builder = ArrayList<UInt64>()
        let firstPair = parseDerIntU64()

        if (firstPair < 40) {
            builder.add(0u64)
            builder.add(firstPair)
        } else if (firstPair < 80) {
            builder.add(1u64)
            builder.add(firstPair - 40)
        } else {
            builder.add(2u64)
            builder.add(firstPair - 80)
        }

        while (hasRemaining) {
            builder.add(parseDerIntU64())
        }

        return Oid(builder)
    }
}
