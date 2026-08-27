// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

class Base12<T> {
       public var d: T
       public mut prop a: T  {
          get(){
            return d

        }
        set(v){
            d = v
            return ()
        }
    }
    public init(a:T) {
       d = a
    }

 }
main() {
    var x  = Base12<Int64>(2)
    x.a = 4
    if(x.a == 4){
        print("${x.a}")
        return 0
    }
    return 1
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
