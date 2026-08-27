// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

class C {
    public var item: Int64 = 100
}

main(): Int64 {
    let c = C()
    func f1(): Result<Int64> {
        let c1 = Result<C>.Ok(c)
        let r1 = c1.item // r1 = 100
        return Result<Int64>.Ok(r1)
    }
    func f2(): Result<Int64> {
        let err = Exception()
        let c2 = Result<C>.Err(err)
        let r2 = c2.item // return Result<Int64>.Err(err)
        return Result<Int64>.Ok(r2)
    }
    return 0
}
