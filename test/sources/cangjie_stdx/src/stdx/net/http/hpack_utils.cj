/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.http

import std.collection.*

type HeaderBlock = ArrayList<Byte>

type HeaderField = (String, String)

type FieldsList = ArrayList<HeaderField>

func fieldSize(field: HeaderField): Int64 {
    return field[0].size + field[1].size + 32
}

enum Index <: ToString {
    EntryIndex(Int64) | NameIndex(Int64) | NoneIndex

    public func toString(): String {
        return match (this) {
            case EntryIndex(index) => "EntryIndex(${index})"
            case NameIndex(index) => "NameIndex(${index})"
            case NoneIndex => "None"
        }
    }

    func isNone(): Bool {
        return match (this) {
            case NoneIndex => true
            case _ => false
        }
    }
}
