/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC: %compiler %cmp_opt  %f  -o %output
// RUN-EXEC: %run %run_opt %output %run_args

func factorial(n: Int64): Int64
{
    if (n==1)
    {
        return 1;
    }else
    {
        return n*factorial(n-1)
    }
}
main() {
    var a: Array<Int64> = [10,21,300,3000]
    try {
        for ( i in a){
            var varname = factorial(i)
            print("letname + ${i}\n" )
        }
    }catch(e:OverflowException){
        e.printStackTrace()
        return 0
    }  
    return 1
}
