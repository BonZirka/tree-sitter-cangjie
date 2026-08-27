// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

interface I{
    func fn1(_:Int64):Int64
    func fn2(_:Int64, _:Int64):Int64
}

class Foo <: I{
    public func fn1(_:Int64):Int64{
        return 0
    }
    public func fn2(_:Int64, _:Int64):Int64{
        return 0
    }
}

main():Int64{
    let a = Foo()
    let b:I = a 
    return b.fn1(1) + b.fn2(1,2)
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
