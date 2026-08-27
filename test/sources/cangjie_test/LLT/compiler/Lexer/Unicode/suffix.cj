// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f

import std.math.*

extend Float64 {
    prop 度: Float64 {
        get() {
            this / 180.0
        }
    }

    prop deg: Float64 {
        get() {
            this
        }
    }
}

extend Int32 {
    prop 房: Int32 {
        get() {
            this
        }
    }
}

main() {
    println(sin(90.0.度))
    println(3.房)
}
