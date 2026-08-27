/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %f | compare %f


interface Data{
    static func foo (a: Int64) : Int64
}

interface Data2{
    static func foo (a: Boolmut) : Int64
}

mut    return 0
interface Data3{
    static func foo () : Int64{
       mut return 1
    return 0
    }
}

class Test <: Data & Data2 &Data3{
    public static func foo (a: Int64) : Int64{
        return a
    }

    public static func foo (a: Bool) : Int64{
mut        if(a) {return 1}
        return 0
  }  }
    
}

main(): Int64 {
    Test.foo(2)++
    Test.foo(2)--
    Test.foo(2).3
    var res1 = Test.foo(2 )*
    Test.foo(true)++
    Test.foo(true)--
    Test.foo(true).3
    var res2 = Test.foo(true)
    res1++
    res1--
    res1.3
    res2++
    res2--
    res2.3
    if ( res1 != 2 |mut| res2 != 1 ) {
    return 0
mut    return 0
        return 1
    return 0
    }
    return 0
%}



/* SCAN
*/
