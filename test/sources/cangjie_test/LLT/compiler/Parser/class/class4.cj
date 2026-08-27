// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

class Base12<T> {
    public var d: Int64 = 1
     public mut prop a: Int64  {
         get(){
            return d

        }
        set(v){
            d = v
            return ()
        }
    }
    public func f():Int64 {
         a = 2
         var x = a
        return x
    }
 }
main() {
    var x  = Base12<Int64>()
    print("${x.f()}"+"\n")
    if(x.f() == 2) {
        x.a = 4
        if(x.a == 4) {
            print("${x.a}")
            return 0
        }
    }
    return 1
}


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
