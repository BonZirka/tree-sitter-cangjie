open class Base{
    open public func returnVal(){0}
}

open class Derive1 <: Base{
    open public func returnVal(){
        1 
    }
}

class Derive2 <: Derive1{
    public func returnVal(){
        2
    }
}

main() {
    let d2:Derive1 = Derive2()
    return d2.returnVal()
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
