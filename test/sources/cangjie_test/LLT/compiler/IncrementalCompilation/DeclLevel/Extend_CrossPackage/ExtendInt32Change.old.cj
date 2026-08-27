package inc

public func u1(): Int64 {
    let a = 3
    a.batch()
}
main() {
    u1()
}

extend Int64 {
    public func batch(): Int64 {
        this
    }
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
