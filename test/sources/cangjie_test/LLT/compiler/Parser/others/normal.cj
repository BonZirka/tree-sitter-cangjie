// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

func foo(a:()->Int64):Int64{
    a()
}

class A{
    public var x = foo
    public func bar(a:()->Int64):Int64{
        a()
    }
}
main():Int64{
    let f = foo
    let instance = A()

    var a = 0
    a += foo(){1}
    a += foo{1}
    a += f(){1}
    a += f{1}
    
    a += instance.bar(){1}
    a += instance.bar{1}
    a += instance.x(){1}
    a += instance.x{1}

    if (a != 8) {
        return 1
    }
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
