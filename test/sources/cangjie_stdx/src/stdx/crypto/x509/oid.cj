/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import std.collection.collectString

struct Oid <: Equatable<Oid> & Hashable & ToString {
    let identifier: String

    init(identifier: String) {
        this.identifier = identifier
    }

    public init(ids: Iterable<UInt64>) {
        this(ids |> collectString<UInt64>(delimiter: "."))
    }

    public override operator func ==(other: Oid): Bool {
        identifier == other.identifier
    }

    public override operator func !=(other: Oid): Bool {
        identifier != other.identifier
    }

    public override func toString(): String {
        identifier
    }

    public override func hashCode(): Int64 {
        identifier.hashCode()
    }
}
