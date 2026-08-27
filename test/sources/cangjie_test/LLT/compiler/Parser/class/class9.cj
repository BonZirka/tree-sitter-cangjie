// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix
open class Base {
    public var c: Int64 = 4
     public open mut prop a: Int64  {
         get(){
            return 0

        }
        set(v){
            return ()
        }
    }

}

open class A <: Base {
    public override mut prop a: Int64 {
        get() {
            return super.c
        }
         set(v){}
    }
}

main() {
    if(A().a == 4)
    {
        return 0
    }
    return 1
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
