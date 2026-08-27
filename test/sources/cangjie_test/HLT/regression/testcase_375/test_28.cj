/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



main(): Int64 {
    if ( B<String,Int6unc foo():Int64{
        return 1
    }
}

interface J<Tnterface I<T> {
    func foo():Int64{
        return 1
    }
}

interface J<T,V> <: I<T> & I<V> {
    prop m:Int64{
        get(){
            return foo()
        }
    }
}

class B<T,V> <: J<T,V> {
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_lt_brace
