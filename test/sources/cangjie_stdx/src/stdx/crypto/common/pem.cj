/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.common

public struct Pem <: Collection<PemEntry> & ToString {
    public Pem(private let items: Array<PemEntry>) {}

    /**
     * Encodes to a textual PEM format.
     *
     * The content will be encoded in UTF-8, DER bodies will be encoded in BASE64.
     * The line endings will be generated according to the current operating system.
     */
    public func encode(): String {
        format(items)
    }

    /**
     * Decode a PEM text into sequence of entries
     * @throw CryptoException - if text is without valid LABLE or is not encoded in base64.
     */
    public static func decode(text: String): Pem {
        Pem(parsePem(text.toArray()))
    }

    public override func toString(): String {
        let sb = StringBuilder()
        for (entry in items) {
            if (sb.size != 0) {
                sb.append(", ")
            }
            sb.append(entry.label)
        }
        return sb.toString()
    }

    public override func isEmpty(): Bool {
        items.isEmpty()
    }

    public override func iterator(): Iterator<PemEntry> {
        items.iterator()
    }

    public override prop size: Int64 {
        get() {
            items.size
        }
    }
}
