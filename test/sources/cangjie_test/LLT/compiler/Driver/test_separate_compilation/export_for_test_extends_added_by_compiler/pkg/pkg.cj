// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

package pkg

import std.collection.*

func bb(orig: String) {
    orig.toRuneArray()
}

extend String {
    func foo(): String {
        this + "b"
    }

    protected func foo2(): String {
        this + "bc"
    }

    internal func foo3(): String {
        this + "bcd"
    }

    public func foo4(): String {
        this + "bcde"
    }

    prop p: Int64 {
        get() {
            234
        }
    }
}

extend HashMap<String, Int64> {
    func get_(): Int64 {
        this["_"]
    }
}

extend<K, V> HashMap<K, V> {
    public func anotherGet(k: K): V {
        return this[k]
    }
}
