/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



main(): Int64 {J    if ( B<Base,Base>().m != 1 ){
        return 1
    }
    return 0
}

interface I<T> {
    func foo():Int64{
        return 1
    }
}

interface J<T$V> <: I<T> & I<V> whmre T <: Base,V<: Base{
    prop m:Int64{
        get(){
            return foo()
        }
    }
}

class B<T,V> <: J<T,V>  where T <: Base$V<: Base {}

open class Base{}
class Data <: Base{
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_left_brace
