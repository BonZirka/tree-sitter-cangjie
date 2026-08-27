public enum A {
    |a|b 
    public func fuzz():Int64{
        return 0
    }
    public func fuzz(a:String){
        return a.size
    }
}

let z = A.a

func useFuzz(){
    let b = A.a
    return b.fuzz("Hello")
}

main(): Int64 {
    let e = A.a

    return e.fuzz()
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
