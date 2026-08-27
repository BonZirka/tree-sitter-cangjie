/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.deriving.Derive

const USTAR_MAGIC = "ustar\0"
const USTAR_VERSION = "00"

const GNU_MAGIC = "ustar "
const GNU_VERSION = " \0"

extend Array<UInt8> {
    operator func ==(other: String): Bool {
        return this == unsafe { other.rawData() }
    }
}

extend String {
    operator func ==(other: Array<UInt8>): Bool {
        return unsafe { this.rawData() } == other
    }
}

@Derive[ToString]
@Derive[Equatable]
public enum TarEntryFormat {
    V7 |    // Unix V7 (1979)
    Ustar | // POSIX.1-1988 (USTAR)
    Pax |   // POSIX.1-2001 (PAX)
    Gnu     // Gnu extension

    func getMagic(): String {
        match (this) {
            case TarEntryFormat.Ustar | TarEntryFormat.Pax => USTAR_MAGIC
            case TarEntryFormat.Gnu => GNU_MAGIC
            case _ => String.empty
        }
    }

    func getVersion(): String {
        match (this) {
            case TarEntryFormat.Ustar | TarEntryFormat.Pax => USTAR_VERSION
            case TarEntryFormat.Gnu => GNU_VERSION
            case _ => String.empty
        }
    }
}
