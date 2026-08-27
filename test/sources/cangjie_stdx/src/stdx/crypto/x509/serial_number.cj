/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.convert.Formattable
import stdx.crypto.crypto.SecureRandom
import stdx.crypto.common.*

public struct SerialNumber <: Equatable<SerialNumber> & Hashable & ToString {
    private let serialNumber_: Array<Byte>

    public init(length!: UInt8 = 16) {
        if (length == 0) {
            throw X509Exception("X509SerialNumber init failed: Certificate serial number must contain at least 1 byte.")
        }

        if (length > 20) {
            throw X509Exception("X509SerialNumber init failed: Certificate serial number should not exceed 20 bytes.")
        }

        let secureRandom = SecureRandom(priv: true)
        this.serialNumber_ = secureRandom.nextBytes(Int32(length))
    }

    init(serialNumber: Array<Byte>) {
        if (serialNumber.size == 0) {
            throw X509Exception("X509SerialNumber init failed: Certificate serial number must contain at least 1 byte.")
        }

        if (serialNumber.size > 20) {
            throw X509Exception("X509SerialNumber init failed: Certificate serial number should not exceed 20 bytes.")
        }
        this.serialNumber_ = serialNumber.clone()
    }

    public override func toString(): String {
        let result = StringBuilder()
        for (elem in serialNumber_) {
            result.append(elem.format("02X"))
        }
        return result.toString()
    }

    public override func hashCode(): Int64 {
        serialNumber_.toString().hashCode()
    }

    public override operator func ==(other: SerialNumber): Bool {
        this.serialNumber_.toString() == other.serialNumber_.toString()
    }

    public override operator func !=(other: SerialNumber): Bool {
        !(this == other)
    }
}
