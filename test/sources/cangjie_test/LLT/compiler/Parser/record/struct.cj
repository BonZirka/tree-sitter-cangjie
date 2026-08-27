// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

struct B{}

struct A{ 
    let t2:Int64  
    init(){
        this.t2 = 2
    }
}
main() {  
    var a = A()
    var b = a.t2    
    if(b != 2){
       return 1 
    }
    return 0
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
