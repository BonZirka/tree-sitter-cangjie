/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
open class Base{
    public func foo(x: Int32): Int32{
        return x + 2
    }
}

class Data<T> <: Base {
    public var a: Int32 = 0
    public Data(){}
    public init(x: T){
        this()
        a = this.foo(3)
    }}

func run(): Int64 {
    var data: Data<Int32> = Data<Int32>(3)
    var res3: Int32 = data.a
    if (res3 == 5) {
        return 0
    }
    return 1
}

main(): Int64 {
    return run()
}



