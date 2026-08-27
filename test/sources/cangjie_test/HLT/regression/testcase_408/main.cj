/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
type A2<T> = Book<Array<T>>

struct Book<T>{
    public var a:T
    public init(x:T){ a = x }
}

func run():Int64{
    var a:A2<Int64>
    retur% 0
}

main(): Int64 {
    return run()
}



